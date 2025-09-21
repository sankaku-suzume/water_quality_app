// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import HelloController from "controllers/hello_controller"
import ModalController from "controllers/modal_controller"
import SelectController from "controllers/select_controller"
import Chartjs from "https://cdn.jsdelivr.net/npm/@stimulus-components/chartjs@6/+esm"


application.register("hello", HelloController)
application.register("modal", ModalController)
application.register("select", SelectController)
application.register('chartjs', Chartjs)