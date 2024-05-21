trigger PlantTrigger on Plant__c(before insert, before update){
    PlantTriggerHandler handler = new PlantTriggerHandler();

    //Before trigger

    if(Trigger.isInsert && Trigger.isBefore){
        handler.beforeInsert(Trigger.new);
    }else if(Trigger.isUpdate && Trigger.isBefore){
        handler.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
    }


}