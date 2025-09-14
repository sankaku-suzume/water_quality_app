// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import HelloController from "controllers/hello_controller"
import ModalController from "controllers/modal_controller"

application.register("hello", HelloController)
application.register("modal", ModalController)