class Plato{
  var property azucar
  method esBonito()
  method calorias() = 3* azucar + 100
}
class Entrada inherits Plato(azucar = 0){
  override method esBonito() = true
}
class Principal inherits Plato(){
  var bonito
  override method esBonito() = bonito
}
class Postre inherits Plato(azucar = 120){
 var cantColores
 override method esBonito() = cantColores > 3
}
class Cocinero{
  var tipo
  method catar(plato) = tipo.catar(plato)
  method cocinar() = tipo.cocinar()
  method cambiarEspecialidad(tipoNuevo){
    tipo = tipoNuevo
  }

}
class Pastelero{
  var nivelDulzor
  method catar(plato){
    return 10.min(5*plato.azucar()/nivelDulzor)
  }
  method cocinar(){
    return new Postre(cantColores = nivelDulzor/50)
  }

}
class Chef{
  var caloriasMaximas
  method catar(plato) {
    if (self.cumpleExpectativas(plato)) return 10 
    else return self.calificacionSiNoCumple(plato)
  } 
  method cumpleExpectativas(plato) = plato.esBonito() && plato.calorias() <= caloriasMaximas

  method calificacionSiNoCumple(plato) = 0
  method cocinar(){
    return new Principal(bonito = true, azucar = caloriasMaximas)
  }

}
class Souschef inherits Chef{
  override method calificacionSiNoCumple(plato) = 6.min(plato.calorias()/100)
  override method cocinar() = new Entrada()
}
class Presentacion{
  const property cocinero
  const property plato
}

class Torneo{
  const catadores = []
  const presentaciones = []

  method participar(cocinero){
    presentaciones.add(new Presentacion(cocinero = cocinero, plato = cocinero.cocinar()))
  }

  method ganador(){
    if (presentaciones.isEmpty()) self.error("El torneo no tuvo participantes")
    return presentaciones.max({ p => self.puntajeDe(p) }).cocinero()
  }

  method puntajeDe(presentacion) =
    catadores.sum({ catador => catador.catar(presentacion.plato()) })
}