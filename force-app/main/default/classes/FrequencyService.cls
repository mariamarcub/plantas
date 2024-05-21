public with sharing class FrequencyService{

    //Static comparte todas las instancias de la clase
    static Map<String, Integer>daysByFrequency = new Map<String, Integer>();

    //Bloque estáticos de inicialización (Se inicia solo una vez)
    static{

        daysByFrequency.put('Daily',1);
        daysByFrequency.put('Twice per week',3);
        daysByFrequency.put('Weekly',7);
        daysByFrequency.put('Every other week',15);
        daysByFrequency.put('Monthly',30);       

    }

    static Set<Integer> summerMonths = new Set<Integer>{5, 6, 7, 8, 9};

    public static Integer getWateringDays(Specie__c specie) { //Determinar la frecuencia de riego de una especie determinada
        Integer month = System.today().month(); //Devuelve el mes
        String frequency;

        if(summerMonths.contains(month)){
            //Verano
            return daysByFrequency.get(specie.Summer_Watering_Frequency__c);
        }else{
            //Invierno
            return daysByFrequency.get(specie.Winter_Watering_Frequency__c);

        }
    
    }

    public static Integer getFertilizationDays(Specie__c specie) { //Determinar la frecuencia de riego de una especie determinada
        Integer month = System.today().month(); //Devuelve el mes
        String frequency;

        if(summerMonths.contains(month)){
            //Verano
            return daysByFrequency.get(specie.Summer_Fertilization_Frequency__c);
        }else{
            //Invierno
            return daysByFrequency.get(specie.Winter_Fertilization_Frequency__c);

        }
    
    }


}