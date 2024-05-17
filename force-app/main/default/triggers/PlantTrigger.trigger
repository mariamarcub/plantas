//Se dispará el Trigger cuando se creen nuevos registros de plantas o se actualicen
trigger PlantTrigger on Plant__c (before insert, before update) {

    /*Variables de contexto que dicen 
    a que evento están respondiendo: Trigger.isBefore, Trigger.isInsert, etc*/   

    if (Trigger.isInsert || Trigger.isUpdate) {
        // Para saber si está cambiando: Trigger.old || Trigger.new (LISTAS) // Trigger.OldMap || Trigger.newMap (MAPAS)
        
        // Declaramos el Set donde almacenar toda la información precargada
        Set<Id> specieIds = new Set<Id>();

        /* Precargar la información necesaria de los objetos relacionados. 
           Hay que hacerlo para evitar hacer el mayor número de Querys posibles. 
           Los triggers pueden traer hasta 200 registros */
        for (Plant__c newPlant : Trigger.new) {

            //Si el trigger es updatem recoge el Id, pero si no es update, entra en el else que es nulo
            Plant__c oldPlant = (Trigger.isUpdate) ? Trigger.oldMap.get(newPlant.Id) : null; 

            //En el insert Trigger.oldMap es nulo
            //Plant__c oldPlant = Trigger.oldMap != null ? Trigger.oldMap.get(newPlant.Id) : null;

            if(oldPlant == null || (oldPlant.Last_Watered__c != newPlant.Last_Watered__c)) {
                specieIds.add(newPlant.Specie__c);
            }
        }

        // Toda la información precargada tras pasar el for. AL hacerlo así, evitamos hacer una query con muchísimos registros
        List<Specie__c> specieList = [SELECT Summer_Watering_Frequency__c FROM Specie__c WHERE Id IN :specieIds];

        // Constructor Mapa
        Map<Id, Specie__c> specieById = new Map<Id, Specie__c>(specieList);

        // Cambiar la siguiente fecha de riego tras haber sido actualizada la fecha        
        for (Plant__c newPlant : Trigger.new) {

            // Recorro todas las plantas con sus nuevos registros
            //Plant__c oldPlant = Trigger.oldMap != null ? Trigger.oldMap.get(newPlant.Id) : null; // Obtener todas las versiones antiguas de las plantas cuyo ID sea la nueva planta
            Plant__c oldPlant = (Trigger.isUpdate) ? Trigger.oldMap.get(newPlant.Id) : null; 

            // Comparar los registros de la fecha de riego
            if (oldPlant == null || (oldPlant.Last_Watered__c != newPlant.Last_Watered__c)) { 
                // Calcular la fecha de riego

                // Ver de qué especie es mi planta
                Id specieId = newPlant.Specie__c; // Cuando haces referencia a un Lookup de apex, te referencia un ID
                
                // Traer objeto especie
                Specie__c specie = specieById.get(specieId);
                
                // Pedir la frecuencia de riego para esa especie
                Integer daysToAdd = FrequencyService.getWateringDate(specie); // Estamos burtificando la información (lo de precargar, guardar y rescatar)

                // Si la fecha riego = a la última fecha de riego + días devueltos
                newPlant.Next_Water__c = newPlant.Last_Watered__c.addDays(daysToAdd); // Como estamos haciendo un before trigger, no hace falta usar el UPDATE cuando cambiamos los registros porque se guardan directamente las actualizaciones en la BD
            }
        }
    }
    // Cuando se crea o actualiza una planta (cambiando su fecha de abonado), que calcule la nueva fecha de abono
}