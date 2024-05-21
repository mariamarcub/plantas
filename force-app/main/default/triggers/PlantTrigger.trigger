trigger PlantTrigger on Plant__c(before insert, before update){
    PlantTriggerHandler handler = new PlantTriggerHandler();

    if(Trigger.isInsert && Trigger.isBefore){
        handler.beforeInsert(Trigger.new);
    } 
    
    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
    } 
}

//En los triggers no se pueden utilizar métodos, por eso se construye la clase