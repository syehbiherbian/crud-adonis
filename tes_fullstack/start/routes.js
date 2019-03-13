'use strict'

/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| Http routes are entry points to your web application. You can create
| routes for different URL's and bind Controller actions to them.
|
| A complete guide on routing is available here.
| http://adonisjs.com/docs/4.1/routing
|
*/

/** @type {typeof import('@adonisjs/framework/src/Route/Manager')} */
const Route = use('Route')

Route.group(() => {
    Route.post('bio', 'BioController.store')
    Route.get('show', 'BioController.index')
    Route.get('bio/:id', 'BioController.show')
    Route.put('bio/:id', 'BioController.update')
    Route.delete('bio/:id', 'BioController.delete')
  }).prefix('api')

Route.on('/').render('index')
