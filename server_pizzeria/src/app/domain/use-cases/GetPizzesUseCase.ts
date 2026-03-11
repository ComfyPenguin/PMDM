import Pizza from "../entities/Pizza.js";
import PizzaRepository, { PaginatedResponse } from "../repositories/PizzaRepository.js";

// Cas d'us per obtindre la llista de pizzes
export default class GetPizzesUseCase {
    
    private pizzaRepository: PizzaRepository;

    constructor(pizzaRepository: PizzaRepository) {
        this.pizzaRepository = pizzaRepository;
    }

    execute(pageNumber: number = 1, pageSize: number = 10): PaginatedResponse<Pizza> {
        return this.pizzaRepository.getPizzes(pageNumber, pageSize);
    }
}
