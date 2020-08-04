import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['query']

  searchSuccess () {
    if (this.queryTarget.value.length) {
      history.pushState(
        {},
        '',
        `/projects/page/1/query/${this.queryTarget.value}`
      )
    } else {
      history.pushState({}, '', `/projects/page/1`)
    }
  }
}
