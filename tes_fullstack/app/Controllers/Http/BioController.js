'use strict'

const Bio = use('App/Models/Bio')
class BioController {
    async index ({response}){
        let bio = await Bio.all();

        return response.header('Content-type', 'application/json').status(200).json(bio)
    }
    async store({ request, response }) {
        const bio_data = request.only(['first_name', 'last_name', 'address', 'email', 'phone'])
    
        const bio = await Bio.create(bio_data)
    
        return response.status(201).json(bio)
      }
    
      async show({ params, response }) {
        const bio = await Bio.find(params.id)
    
        return response.status(200).json(bio)
      }
    
      async update({ params, request, response }) {
        const bio_data = request.only(['first_name', 'last_name', 'address', 'email', 'phone'])
    
        const bio = await Bio.find(params.id)
        if (!bio) {
          return response.status(404).json({ data: 'Data not found' })
        }
        bio.first_name = bio_data.first_name
        bio.last_name  = bio_data.last_name
        bio.address    = bio_data.address
        bio.email      = bio_data.email
        bio.phone      = bio_data.phone
    
        await bio.save()
    
        return response.status(200).json(bio)
      }
    
      async delete({ params, response }) {
        const bio = await Bio.find(params.id)
        if (!bio) {
          return response.status(404).json({ data: 'Data not found' })
        }
        await bio.delete()
    
        return response.status(204).json(null)
      }
}

module.exports = BioController
