% rebase('base.tpl', title='Page Title')

<br>

<div class="jumbotron" style="background: #f8f8f8;">
  <div class="container">
    <h3 class="text-center">Welcome to vivo Blog!</h3><br>
    <p class="lead text-center">Read about the latest happening in the tech world...</p>
  </div>
</div>


<div class="lead">
	<a href="/admin/add-post" class="btn btn-primary">Add Post</a>
</div><br>

%if len(posts) < 1:
   <h3 class="text-center"> No blog post at the moment, check back later... </h3>
%end

%for post in posts:
    <div class="card">
      <div class="card-header">
        <h5> {{post['title']}}</h5>
      </div>
      <div class="card-body">
        <p class="card-text" style="white-space: pre-line;">{{post['content']}}</p>
        <p class="card-text text-muted text-right">{{post['date']}}</p>
        <a href="/post/{{post['id']}}" target="_blank" class="btn btn-primary">View</a>
        <a href="/admin/post/update/{{post['id']}}" class="btn btn-info">Edit</a>
        <a href="/admin/post/delete/{{post['id']}}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this post?')">Delete</a>
      </div>
    </div> <br>
%end