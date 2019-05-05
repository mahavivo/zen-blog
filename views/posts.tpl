% rebase('base.tpl', title='Page Title')

<br>


<div class="jumbotron" style="background: #f8f8f8;">
  <div class="container">
    <h3 class="text-center">Welcome to vivo's Blog!</h3><br>
    <p class="lead text-center">Read about the latest happening in the tech world...</p>
  </div>
</div>



%if len(posts) < 1:
   <h3 class="text-center"> No blog post at the moment, check back later... </h3>
%end

%for post in posts:
    <div class="card border-0">

      <div class="card-block" style="font-family:PingFangSC,Arial,'Hiragino Sans GB';">


        <a href="/post/{{post['id']}}">
        <h5 class="card-title">{{post['title']}}</h5>
        </a>

        <p class="card-text" style="white-space: pre-line;">{{!post['content']}}</p>
        <p class="card-text text-muted text-right">{{post['date'][0:10]}}</p>
<!--
        <a href="/post/{{post['id']}}" class="btn btn-link">View</a>
-->

      </div>
    </div> <br>
%end
