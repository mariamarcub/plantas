public with sharing class FrequencyService {
    
    //Static comparte todas las instancias de la clase
    static Map<String, Integer>daysByFrequency = new Map<string, Integer>();

    //Bloque estáticos de inicialización (Se inicia solo una vez)
    static{

        daysByFrequency.put('Daily',1);
        daysByFrequency.put('Twice per week',3);
        daysByFrequency.put('Weekly',7);
        daysByFrequency.put('Every other week',15);
        daysByFrequency.put('Monthly',30);
        daysByFrequency.put('Every three months',90);
        daysByFrequency.put('Not needed',999);

    }
    

    static Set<Integer> summerMonths = new Set<Integer>{5, 6, 7, 8, 9};

    public static Integer getWateringDate(Specie__c specie) {
        

        
    }

    public static Integer getFertilizationDate(Specie__c specie) {
        return 30;
    }
}