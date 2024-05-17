public with sharing class SpeciesService { //Método de apex
    @AuraEnabled(cacheable=true)
    public static List<Specie__c>getFilteredSpecie(String searchText) { //Para llamar un metodo desde el Lighningt web component, tienen que ser Static
        String likeValue = '%' + searchText + '%';
        return [
            SELECT Id, Name, Description__c, Image_URL__c, Location__c
            FROM Specie__c
            WHERE Name
            LIKE :likeValue
        ];
    }
}

//Cuando yo llamo a este método por primera vez, se guarda la caché en el navegador