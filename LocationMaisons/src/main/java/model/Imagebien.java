package model;

public class Imagebien {
    private int idImage;
    private int idBien;
    private String chemin; // le chemin du fichier image (ex: maison1.jpg)

    // Getters et Setters
    public int getIdImage() {
        return idImage;
    }

    public void setIdImage(int idImage) {
        this.idImage = idImage;
    }

    public int getIdBien() {
        return idBien;
    }

    public void setIdBien(int idBien) {
        this.idBien = idBien;
    }

    public String getChemin() {
        return chemin;
    }

    public void setChemin(String chemin) {
        this.chemin = chemin;
    }
}
