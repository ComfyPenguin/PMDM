export default class Pizza {
    private _id: string;
    private _nom: string;
    private _desc: string;
    private _vegetariana: boolean;
    private _alergens: string[];
    private _img: string;
    private _preu: number;

    constructor(id: string, nom: string, desc: string, vegetariana: boolean, alergens: string[], img: string, preu: number) {
        this._id = id;
        this._nom = nom;
        this._desc = desc;
        this._vegetariana = vegetariana;
        this._alergens = alergens;
        this._img = img;
        this._preu = preu;
    }

    // Getters
    get id(): string {
        return this._id;
    }

    get nom(): string {
        return this._nom;
    }

    get desc(): string {
        return this._desc;
    }

    get vegetariana(): boolean {
        return this._vegetariana;
    }

    get alergens(): string[] {
        return this._alergens;
    }

    get img(): string {
        return this._img;
    }

    get preu(): number {
        return this._preu;
    }
}