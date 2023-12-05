# NetworkManager
SDK para llamada a servicios

:::::::::::::::::::::::::::::::: Ejemplo de Implementación ::::::::::::::::::::::::::::::::
1) Clonar el repositorio en una nueva carpeta llamada "NetworkManagerSDK" dentro del path del proyecto a implementar

2) Modificar Podfile de su proyecto con las siguiente línea
      pod 'NetworkManagerSDK', :path => 'NetworkManagerSDK'
      
3) Instalar los pods en su proyecto

4) Para hacer las peticiones en el Model, seguir el siguiente ejemplo:

//Import del framework
import NetworkManagerSDK

//Instancia de la clase WebService
var ws : WebService = WebService()

//Consumir funciones con peticiones a servicios
self.ws.getCharacters { response, error in
    if let _ = error {
        print("ERROR: \(error!.errorMessage) - (\(error!.error))")
    }else{
        print("Success WS")
    }
}
        
//(Opcional) Implementación de notificación estatus de servicio
self.ws.callbackServices = { response in
    if response.status == statusService.start{
        print("Mostrar Loader...")
    }else if response.status == statusService.finish{
        print("Ocultar Loader...")
    }
}

:::: Author: Ignacio Hernandez Montes ::::::::::::::::::::::::::::::::::::::::::::::::::


