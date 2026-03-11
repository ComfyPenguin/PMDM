import Pizza from "../entities/Pizza.js";

// Interfície per a la resposta paginada
export interface PaginatedResponse<Pizza> {
    page: number;
    per_page: number;
    total_count: number;
    records: Pizza[];
}

// Repositori abstracte
export default abstract class PizzaRepository {
    abstract getPizzes(pageNumber: number, pageSize: number): PaginatedResponse<Pizza>;
}