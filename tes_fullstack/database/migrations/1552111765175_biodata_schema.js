'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class BiodataSchema extends Schema {
  up () {
    this.create('biodata', (table) => {
      table.increments()
      table.string('first_name', 35)
      table.string('last_name', 40)
      table.string('address')
      table.string('email')
      table.string('phone')
      table.timestamps()
    })
  }

  down () {
    this.drop('biodata')
  }
}

module.exports = BiodataSchema
