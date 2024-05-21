public with sharing class PlantTriggerHandler {
    public void beforeInsert(List<Plant__c> newSObjects) {
        Set<Id> specieIds = new Set<Id>();
        
        for (Plant__c newPlant : newSObjects) {
            specieIds.add(newPlant.Specie__c);
        }
      
        Map<Id, Specie__c> speciesById = preloadRealtedSpecies(specieIds);

        for (Plant__c newPlant : newSObjects) {
            // Prepopulate New Watering Date
            populateNextWateringDate(newPlant, speciesById);
        }
    } // Cerramos beforeInsert

    public void beforeUpdate(
        List<Plant__c> oldSObjects,
        Map<Id, Plant__c> oldSObjectsMap,
        List<Plant__c> updatedObjects,
        Map<Id, Plant__c> updatedObjectsMap            
    ) {
        // Cuando se crea o actualiza una planta (cambiando su fecha riego) --> Calcular siguiente fecha de riego
        // Precargar información necesaria de los obj relacionados
        Set<Id> specieIds = new Set<Id>();

        // Recopilar los IDs de las especies de las plantas actualizadas
        for (Plant__c newPlant : updatedObjects) {
            specieIds.add(newPlant.Specie__c);
        }

        // Cargar las especies relacionadas en speciesById
        Map<Id, Specie__c> speciesById = preloadRealtedSpecies(specieIds);

        for (Plant__c newPlant : updatedObjects) {
            Plant__c oldPlant = oldSObjectsMap.get(newPlant.Id);
            // No hace falta mirar si es nulo o no porque al ser Update ya existe
            if (oldPlant.Last_Watered__c != newPlant.Last_Watered__c) {
                populateNextWateringDate(newPlant, speciesById);
            }
        }

        for (Plant__c newPlant : updatedObjects) {
            Plant__c oldPlant = (Plant__c) oldSObjectsMap.get(newPlant.Id);
            // Calcular sig fecha de riego
            // Ver de qué especie es mi planta
            Id specieId = newPlant.Specie__c;
            // Traer el obj especie
            Specie__c specie = speciesById.get(specieId);
            // Pedir frecuencia de riego para esa especie
            Integer daysToAdd = FrequencyService.getWateringDays(specie);
            // Siguiente fecha riego = última fecha de riego + días devueltos
            newPlant.Next_Water__c = newPlant.Last_Watered__c.addDays(daysToAdd);
        }            
    }

    static Map<Id, Specie__c> preloadRealtedSpecies(Set<Id> specieIds) {
        // Query precarga objetos relacionados
        List<Specie__c> species = [
            SELECT Summer_Watering_Frequency__c, Winter_Watering_Frequency__c
            FROM Specie__c
            WHERE Id IN :specieIds
        ];
        return new Map<Id, Specie__c>(species); // Devuelve el mapa
    }

    // Populate porque lo calculas y lo seteas
    private static void populateNextWateringDate(Plant__c newPlant, Map<Id, Specie__c> speciesById) {
        // Calcular sig fecha de riego
        // Ver de qué especie es mi planta
        Id specieId = newPlant.Specie__c;
        // Traer el obj especie
        Specie__c specie = speciesById.get(specieId);
        // Pedir frecuencia de riego para esa especie
        Integer daysToAdd = FrequencyService.getWateringDays(specie);
        // Siguiente fecha riego = última fecha de riego + días devueltos
        newPlant.Next_Water__c = newPlant.Last_Watered__c.addDays(daysToAdd);
    } // Cerramos populate 
} // Cerramos la clase
