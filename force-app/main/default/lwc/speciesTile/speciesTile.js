import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
    
    export default class SpeciesTile extends NavigationMixin(LightningElement) {
        /*specie = 
            {
                Name: "Aloe Vera",
                Description: "Es una planta medicinal",
                Image_URL__c:
                    "https://upload.wikimedia.org/wikipedia/commons/d/d7/Aloe_vera_-_Agri-Horticultural_Society_of_India_-_Alipore_-_Kolkata_2013-01-05_2327.JPG",
                Location__c: "Outdoors"
            };*/

        @api specie; //Se utiliza specie en specieList.html
        
        //Llamamos a la variable definida en el html para conseguir que muestre el icono
        get isOutdoors(){
            return this.specie.Location__c.includes("Outdoors");
        }

        get isIndoors(){
            return this.specie.Location__c.includes("Indoors");
        }

        navigateToRecordViewPage(){
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes:{
                   // recordId: 'a0AWU000000LW892AG', Esta ID se encuentra en la URL o buscando el campo desde la extensión query
                    recordId: this.specie.Id, //Aquí se coge de forma dinámica el ID de cada especie
                    objectApiName: 'Specie_c', //Este campo es opcional
                    actionName: 'view'
                }
            });
        }
    }