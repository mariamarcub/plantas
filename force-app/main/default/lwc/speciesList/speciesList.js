import { LightningElement, wire } from 'lwc';
import getFilteredSpecie from "@salesforce/apex/SpeciesService.getFilteredSpecie";

export default class SpeciesList extends LightningElement {
    
    //Propiedades, get y setter
    searchText = ''; // Inicializar la propiedad

    //Constructor

    // Wire 
    @wire(getFilteredSpecie, { searchText: '$searchText' }) //Se llama en el segundo parámetro a la propiedad
    species;

    // Method to handle input change
    handleInputChange(event) {
        const searchTextAux = event.target.value;
        if (searchTextAux.length >= 3 || searchTextAux === '') {
            this.searchText = searchTextAux;
        }
    }
}