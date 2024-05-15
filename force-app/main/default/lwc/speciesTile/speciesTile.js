import { LightningElement, api } from 'lwc';
    
    export default class SpeciesTile extends LightningElement {
        /*specie = 
            {
                Name: "Aloe Vera",
                Description: "Es una planta medicinal",
                Image_URL__c:
                    "https://upload.wikimedia.org/wikipedia/commons/d/d7/Aloe_vera_-_Agri-Horticultural_Society_of_India_-_Alipore_-_Kolkata_2013-01-05_2327.JPG",
                Location__c: "Outdoors"
            };*/

        @api specie; //Se utiliza specie en specieList.html
        
          

    }