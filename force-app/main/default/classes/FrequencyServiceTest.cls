@isTest
private with sharing class FrequencyServiceTest {
//with sharing respeta la seguridad a nivel de registro del usuario
//without sharing es la otra opción que es cuando quiero saltarme la seguridad a nivel de registro
    @isTest
    static void getWateringDays_WateringFreqDailyAndSummer_OneDay(){
        
        //GIVEN -- Creación de datos, escenario..
        Specie__c specie  = new Specie__c();
        specie.Summer_Watering_Frequency__c = 'Daily';

        //WHEN -- Llamamos al métodos
        Integer days = FrequencyService.getWateringDays(specie);
        //THEN -- Chequear el resultado esperado
        Integer expectedDays = 1;
        //El método assert sirve para comprobar que dos valores son iguales o uno de ellos es true. Si no lo son, fallará el test
        system.assertEquals(expectedDays, days, 'Expected 1 day returned');
    }

    @isTest
    static void getWateringDays_WateringFreqDailyAndSummer_Month(){
        //GIVEN -- Creación de datos, escenario..
        Specie__c specie  = new Specie__c();
        specie.Summer_Watering_Frequency__c = 'Monthly';

        //WHEN -- Llamamos al métodos
        Integer days = FrequencyService.getWateringDays(specie); //otro parámetro para el mock: instanceDateServiceMock
        //THEN -- Chequear el resultado esperado
        Integer expectedDays = 30;
        //El método assert sirve para comprobar que dos valores son iguales o uno de ellos es true. Si no lo son, fallará el test
        system.assertEquals(expectedDays, days, 'Expected 1 day returned');
    }

    /*Crear Mock

    public class DateServiceMock implements system.StubProvider{
        
        public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,
            Type returnType, List<Type> listOfParamTypes, List<String> listOfParamTypes,
            List<Object> listOfArgs){

                for(integer i=0; i < listOfParamNames.size();i++){
                    System.debug('parameter name' + listOfParamNames.get(i));
                    System.debug('parameter type' + listOfParamTypes.get(i).getName());

                }

                //Emular lo que queremos que haga el método

                
            }
    }*/
}