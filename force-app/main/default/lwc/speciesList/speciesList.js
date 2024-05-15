import { LightningElement, wire } from 'lwc';
import getAllSpecies from "@salesforce/apex/SpeciesService.getAllSpecies";
export default class SpeciesList extends LightningElement {
   /* species = [
        {
            Name: "Aloe Vera",
            Description: "Es una planta medicinal",
            Image_URL__c:
                "https://upload.wikimedia.org/wikipedia/commons/d/d7/Aloe_vera_-_Agri-Horticultural_Society_of_India_-_Alipore_-_Kolkata_2013-01-05_2327.JPG",
            Location__c: "Outdoors"
        },
        {
            Name: "Jazmin",
            Description: "Flores Blancas",
            Image_URL__c:
                "https://media.floresfrescasonline.com/product/jazmin-polyanthum-800x800.jpg",
            Location__c: "Outdoors"
        },
        {
            Name: "Echinopsis",
            Description: "Cactus con flor grande",
            Image_URL__c:
                "https://upload.wikimedia.org/wikipedia/commons/a/a5/Echinopsis_oxygona_%284%29.jpg",
            Location__c: "Outdoors"
        }
    ];
    */

    @wire(getAllSpecies)
    species;
}