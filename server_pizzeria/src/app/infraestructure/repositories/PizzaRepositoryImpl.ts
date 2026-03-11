import Pizza from "../../domain/entities/Pizza.js";
import PizzaRepository, { PaginatedResponse } from "../../domain/repositories/PizzaRepository.js";
import pizzesData from "../data-sources/PizzaData.json" with { type: "json" };

export default class PizzaRepositoryImpl extends PizzaRepository {
    
    // Obtenir pizzes amb paginació
    getPizzes(pageNumber: number, pageSize: number): PaginatedResponse<Pizza> {
        let startIndex = (pageNumber - 1) * pageSize;
        let endIndex = startIndex + pageSize;

        if (pageNumber === -1 || pageSize === -1) {
            // Si qualsevol dels dos és -1, 
            // Tornem totes les pizzes
            startIndex = 0;
            endIndex = pizzesData.length;
        }

        const pizzesSlice = pizzesData.slice(startIndex, endIndex);
        const pizzes: Pizza[] = [];
        
        for (const p of pizzesSlice) {
            const pizza = new Pizza(
                p.id,
                p.nom,
                p.desc,
                p.vegetariana,
                p.alergens,
                p.img || "",
                p.preu
            );
            pizzes.push(pizza);
        }

        return {
            page: pageNumber,
            per_page: pageSize,
            total_count: pizzes.length,
            records: pizzes,
        };
    }
}
