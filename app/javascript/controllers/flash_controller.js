import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect () {
    setTimeout(this.remove.bind(this), 2000)
  }

  remove () {
    this.element.remove()
  }
}
