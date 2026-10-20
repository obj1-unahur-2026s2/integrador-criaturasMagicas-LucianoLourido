class Criaturas{
  const astucia 
  var poderMagico
  var rol  

  method reino()  
  method esAstuto()
  method astucia() = astucia
  method rol() = rol  
  method poderMagico() = poderMagico
  method poderOfensivo()= (self.poderMagico() * 10) + rol.poderExtra(self)
  method esExtraordinaria()= rol.esExtraordinario(self)
  method esFormidable() = self.esAstuto() or self.esExtraordinaria()
  method cambiarRol(){
    rol = rol.hacerRitual(self)
  } 
  method perderPoderMagico(){poderMagico *= 0.85 }
}

class Duende inherits Criaturas{
  override method reino() = "Reino del Bosque"
  override method poderOfensivo()=  super() * 1.10 
  override method esAstuto() =   false
}
class Hadas inherits Criaturas{
  var kmVolar = 2
  override method reino() = "Reino de los Cielos" 
  method kmAumentoVolar(cantidadKm){
    kmVolar = (kmVolar + cantidadKm).min(25)
  } 
  method kmVolar() = kmVolar 
  override method esAstuto() =  astucia > 50 
  override method esExtraordinaria() = super() and kmVolar > 10 
}

object guardian {
  method poderExtra(unRol) = 100 
  method esExtraordinario(criatura) = criatura.poderMagico() > 50
  method hacerRitual(criatura){
    const nuevoDomador = new Domador()
    nuevoDomador.addMascota(new Mascotas(tieneCuerno = false, edad = 1))
    return nuevoDomador
  }
}

object hechicero {
  method poderExtra(unRol) = 0 
  method esExtraordinario(criatura) = true
  method hacerRitual(criatura){
    return guardian
  }
}
class Domador { 
  const mascotas = []
  
  method mascotas() = mascotas 
  method addMascota(nuevaMascota){
    mascotas.add(nuevaMascota)
  } 
  method cantMascotasConCuernos() = mascotas.count({m => m.tieneCuerno()})
  method poderExtra(unRol) = 150 * self.cantMascotasConCuernos()
  method esExtraordinario(criatura) = criatura.poderMagico() >= 15 and mascotas.all({m => m.esVeterana()}) 
  method hacerRitual(criatura){
    if (self.cantMascotasConCuernos() ==0)
      self.error("El ritual se cancela") 
    return hechicero
  }
}

class Mascotas{
  const tieneCuerno
  var edad 

  method edad() = edad
  method tieneCuerno() = tieneCuerno 
  method esVeterana() = edad >= 10   
}

class Colonia{
  const criaturas = []

  method addCriaturas(nuevaCriaturas){
    criaturas.add(nuevaCriaturas)
  } 
  method poderOfensivoColonia() = criaturas.sum({c => c.poderOfensivo()})
  method cantidadDeFormidable() =  criaturas.count({c => c.esFormidable()})
  method perderPoderMagico() { criaturas.forEach({c => c.perderPoderMagico()}) }
  method usurpar(area) = 
  if (self.poderOfensivoColonia() > area.poderDefensivoColonia()) 
    area.habitar(self) 
  else 
    self.perderPoderMagico()
}

class Area{
  var colonia

  method colonia() = colonia 
  method habitar(nuevaColonia){ 
    colonia = nuevaColonia 
    }
  method poderDefensivoColonia() 

}

class Claro inherits Area{
  override method poderDefensivoColonia() =  colonia.poderOfensivoColonia() + 100
}

class Castillo inherits Area{
  override method poderDefensivoColonia() = 200 * colonia.cantidadDeFormidable()
}