% rebase('base.tpl', title='Page Title')


%if status is not None:
	<div class="alert alert-success" role="alert">
	  <strong>Post updated!</strong>
	</div>
%end

<section class="container">
<div class="text-left"><br>
	<a href="/admin/dashboard" class="btn btn-primary">Back</a>
</div>
</section>

<br><section class="container">
  <form method="POST">
  	<input type="hidden" name="post_id" value="{{post['id']}}">
	  <div class="form-group">
	    <label for="title">Title</label>
	    <input type="text" class="form-control" name="title" value="{{post['title']}}" id="title">
	  </div>

	  <div class="form-group">
	    <label for="Textarea">Content</label>
	    <textarea class="form-control" id="Textarea" rows="12" name="content">{{post['content']}}</textarea>
	  </div>
  
	  <button type="submit" class="btn btn-primary">Submit</button>
 </form> <br>
</section>