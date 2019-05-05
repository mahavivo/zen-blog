% rebase('base.tpl', title='Page Title')


%if status is not None:
	<div class="alert alert-success" role="alert">
	  <strong>Post added!</strong>
	</div>
%end

<section class="container">
<div class="text-left"><br>
	<a href="/admin/dashboard" class="btn btn-primary">Back</a>
</div>
</section>


<section class="container" style="margin-top: 40px;">
  <form method="POST">
	  <div class="form-group">
	    <label for="title">Title</label>
	    <input type="text" class="form-control" name="title" id="tilte" required>
	  </div>

	  <div class="form-group">
	    <label for="Textarea">Content</label>
	    <textarea class="form-control" id="Textarea" rows="12" name="content" required></textarea>
	  </div>

	  <button type="submit" class="btn btn-primary">Submit</button>
 </form> <br>
</section>