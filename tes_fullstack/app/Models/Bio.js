'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class Bio extends Model {
    static get table () {
        return 'biodata'
      }
}

module.exports = Bio
