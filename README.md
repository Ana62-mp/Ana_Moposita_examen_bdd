# Ana_Moposita_examen_bdd
Examen del curso Fundamentos de bases de datos por Ana Moposita
Link video: https://drive.google.com/file/d/1pm2_1K0ZlA78NqKam1Ptxly5tSqBdEWY/view?usp=sharing

## Parte 3 - Mantenimiento y extensibilidad

Para la Parte 3 se agregó el campo destino al sistema de vuelos, porque el nuevo requisito pide registrar hacia qué lugar se dirige cada vuelo. Primero se modificó la tabla vuelos en PostgreSQL con ALTER TABLE vuelos ADD COLUMN destino VARCHAR(100);, ya que el destino es un dato de texto. Luego se actualizó la entidad Vuelo.java, agregando el atributo destino con su anotación @Column, además de su getter, setter, constructor y toString, para que Java pueda recibir, mostrar y guardar ese nuevo dato.

También se modificó el método actualizar en VueloService.java, agregando vueloExistente.setDestino(vuelo.getDestino());, porque al hacer un PUT el sistema debe permitir cambiar también el destino del vuelo. No fue necesario modificar VueloRepository.java, porque este repositorio trabaja con la entidad completa y ya hereda los métodos de JpaRepository. Tampoco fue necesario cambiar la estructura del VueloController.java, porque los métodos POST y PUT reciben el objeto completo mediante @RequestBody, entonces Spring puede tomar automáticamente el nuevo campo destino desde el JSON enviado en Postman.
