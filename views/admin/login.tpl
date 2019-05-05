% rebase('base.tpl', title='Page Title')

<section class="Aligner" style="margin-top: 50px;">
	<form method="POST" action="/admin/login">
	  <div class="form-group">
	    <label for="usernameInput">username</label>
	    <input type="text" class="form-control" name="username" placeholder="Username" required="">
	  </div>
	  <div class="form-group">
	    <label for="passwordInput">password</label>
	    <input type="password" class="form-control" name="password" placeholder="Password" required>
	  </div>

	    <button type="submit" class="block btn btn-primary">sign in</button>
	</form>
</section>
