<table-biodata>
    <div class="container">
	<div class="row">
		
        
        <div class="col-md-12">
        <button class="btn btn-primary" data-toggle="modal" data-target="#tambah" onclick="{addBio}" >Tambah Data</button>
        <div class="table-responsive">

                
    <table id="mytable" class="table table-bordred table-striped">
        <thead>
        <th><input type="checkbox" id="checkall" /></th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Address</th>
        <th>Email</th>
        <th>Contact</th>
        <th>Edit</th>
        <th>Delete</th>
        </thead>
        <tbody>
        <tr each={data in opts.bio}>
        <td><input type="checkbox" class="checkthis" /></td>
        <td>{data.first_name}</td>
        <td>{data.last_name}</td>
        <td>{data.address}</td>
        <td>{data.email}</td>
        <td>{data.phone}</td>
        <td><p data-placement="top" data-toggle="tooltip" title="Edit"><button class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" id="{data.id}" data-id="{data.id}" onclick="{editBio}"><span class="glyphicon glyphicon-pencil"></span></button></p></td>
        <td><p data-placement="top" data-toggle="tooltip" title="Delete"><button class="btn btn-danger btn-xs" data-title="Delete" id="{data.id}" data-id="{data.id}" data-toggle="modal" data-target="#delete" onclick="{() => showDeleteModal(data._id)}"><span class="glyphicon glyphicon-trash"></span></button></p></td>
        </tr>
        </tbody>
    </table>

            <div class="clearfix"></div>
                <ul class="pagination pull-right">
                <li class="disabled"><a href="#"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
                <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
                </ul>
            </div>
            
        </div>
	</div>
</div>

<div class="modal fade" id="tambah" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        <h4 class="modal-title custom_align" id="Heading">Tambah Data</h4>
      </div>
        <div class="modal-body">
	   				<input type="hidden" ref="id" id="id" value="">
            <div class="form-group">
            <input class="form-control" type="text" placeholder="First Name" ref="first" id="first">
            </div>
            <div class="form-group">
            <input class="form-control " type="text" placeholder="Last Name" ref="last" id="last">
            </div>
            <div class="form-group">
            <textarea rows="2" class="form-control" placeholder="Address" ref="address" id="address"></textarea>
            </div>
            <div class="form-group">
            <input class="form-control " type="text" placeholder="Email" ref="email" id="email">
            </div>
            <div class="form-group">
            <input class="form-control " type="text" placeholder="Phone Number" ref="phone" id="phone">
            </div>
        </div>
          <div class="modal-footer ">
        <button type="button" class="btn btn-primary btn-lg" style="width: 100%;" onclick={saveBio}><span class="glyphicon glyphicon-plus"></span>Save</button>
      </div>
        </div>
    <!-- /.modal-content --> 
  </div>
      <!-- /.modal-dialog --> 
    </div>
    
    <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      <div class="modal-dialog">
    	<div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        <h4 class="modal-title custom_align" id="Heading">Delete this entry</h4>
      </div>
          <div class="modal-body">
       
       <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>
       
      </div>
        <div class="modal-footer ">
	   		<input type="hidden" ref="id" id="data" value="">
        <button type="button" class="btn btn-success" id="confirm" value="yes" onclick="{deleteBio}"><span class="glyphicon glyphicon-ok-sign"></span> Yes</button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
      </div>
        </div>
    <!-- /.modal-content --> 
        </div>
      <!-- /.modal-dialog --> 
    </div>
    <script>
		this.selectedID;

		this.on('mount', function(){
			opts.callback(this) 
		})

		this.on('data_loader', function(bio){
			opts.bio = bio
			this.update()
		})

		addBio() {
			clearForm()
		}

		editBio(bio) {
			axios.get('http://127.0.0.1:3333/api/bio/'+bio.item.data._id)
			.then(function(response){
				if (response.status == 200) {
					openForm()
					bio = response.data
					document.getElementById("id").value = bio._id
					document.getElementById("first").value = bio.first_name
					document.getElementById("last").value = bio.last_name
					document.getElementById("address").value = bio.address
					document.getElementById("email").value = bio.email
					document.getElementById("phone").value = bio.phone
	        }
	      });
		}
		function openForm() {
				$('#tambah').modal('show');			
		}

		saveBio(e) {

        	e.preventDefault();
        	var self = this
					var id = document.getElementById("id").value
					var first = document.getElementById("first").value
					var last = document.getElementById("last").value
					var address = document.getElementById("address").value
					var email = document.getElementById("email").value
					var phone = document.getElementById("phone").value
					var check_data = validateForm(first, last, address, email, phone)
					if (check_data === false) {
						return
					}
					
					if (id == "") {
					axios.post('http://127.0.0.1:3333/api/bio', {
						first_name: first,
						last_name: last,
						address: address,
						email : email,
						phone : phone
					})
					.then(function(response){
					loadBiodata(self)
					swal("Sukses", "Data Berhasil Ditambah", "success");
					clearForm()
					closeForm()
					});
					} else {
					axios.put('http://127.0.0.1:3333/api/bio/'+id, {
						first_name: first,
						last_name: last,
						address: address,
						email : email,
						phone : phone
					})
					.then(function(response){
					loadBiodata(self)
					swal("Sukses", "Data berhasil di update!", "success");
					clearForm()
					closeForm()
						});
					}
		}

		showDeleteModal(id){
			this.selectedID = id;
			console.log('selectedID', this.selectedID)
		}

		deleteBio(){
			var self = this;

			axios.delete('http://127.0.0.1:3333/api/bio/'+this.selectedID)
				.then(function(response){
					if (response.status == 204) {
						swal("Good job!", "You clicked the button!", "success");
						loadBiodata(self)	
						$("#delete").modal('hide');
					}
				});	
		}

		function closeForm(){
			$('#tambah').modal('hide');		
		}
		function clearForm() {
			var first = document.getElementById("first").value = '';
			var last = document.getElementById("last").value = '';
			var address = document.getElementById("address").value = '';
			var email = document.getElementById("email").value = '';
			var phone = document.getElementById("phone").value = '';
		}

		function validateForm(first, last, address, email, phone){
			if (first=="") {
				swal("Gagal", "First Name is Required", "error");
				return false
			}
			if (last=="") {
				swal("Gagal", "Last Name is Required", "error");
				return false
			}
			if (address=="") {
				swal("Gagal", "Address is Required", "error");
				return false
			}
			if (email=="") {
				swal("Gagal", "Email is Required", "error");
				return false
			}
			if (phone=="") {
				swal("Gagal", "Phone Number is Required", "error");
				return false
			}
			return true
		}
    </script>
</table-biodata>