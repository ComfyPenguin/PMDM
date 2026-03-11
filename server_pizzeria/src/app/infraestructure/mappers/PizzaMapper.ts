import Pizza from "../../domain/entities/Pizza.js";

// Mapper a JSON
export default class PizzaMapper {
    
    static toJSON(pizza: Pizza): object {
        return {
            id: pizza.id,
            nom: pizza.nom,
            desc: pizza.desc,
            vegetariana: pizza.vegetariana,
            alergens: pizza.alergens,
            img: pizza.img,
            preu: pizza.preu
        };
    }
}
