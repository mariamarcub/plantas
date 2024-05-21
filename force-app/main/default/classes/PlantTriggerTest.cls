@isTest
public with sharing class PlantTriggerTest {
    @isTest
    static void insertPlant_lastWateredSetup_nextWateringDateCalculatedCorretly(){

        Specie__c orquidea = new Specie__c();
        orquidea.Summer_Watering_Frequency__c = 'Weekly';
        insert orquidea;

        Plant__c plant1 = new Plant__c();
        plant1.Last_Fertilized__c = System.today();
        plant1.Last_Watered__c = System.today();
        plant1.Specie__c = orquidea.Id;

        insert plant1;

        plant1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :plant1.Id];
        System.assertEquals(System.today() + 7, plant1.Next_Water__c);
    }
}