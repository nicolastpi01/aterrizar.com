package ar.edu.unq.epers.aterrizar.home

import java.util.Calendar
import java.util.Date
import java.sql.Timestamp
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class FechaParaReservaValida {
	
	Calendar chequeoFin = Calendar.getInstance()
	Calendar chequeoInicio = Calendar.getInstance()
	Timestamp fechaChequeoFin
	Timestamp fechaChequeoInicio
	
	new() {
		chequeoFin.setTime(new Date())
		chequeoInicio.setTime(new Date())
		chequeoInicio.add(Calendar.MINUTE, -5)
		fechaChequeoFin = new Timestamp(chequeoFin.getTime().getTime())
		fechaChequeoInicio = new Timestamp(chequeoInicio.getTime().getTime())
	}
}