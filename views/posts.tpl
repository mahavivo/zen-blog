% rebase('base.tpl', title='Page Title')

<br>


<div class="jumbotron" style="background: #f6f6f6;">
  <div class="container">
    <h3 class="text-center">Welcome to vivo's Blog!</h3><br>
    <p class="lead text-center">Read about the latest happening in the tech world...</p>
  </div>
</div>



%if len(posts) < 1:
   <h3 class="text-center"> No blog post at the moment, check back later... </h3>
%end

%for post in posts[:5]:
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

<br>
<div class="card bg-light border-0" style="font-size:18px;">
    <br>
    <div class="card-text">
    <span style="float:left;">READ MORE ⟿</span>
    <a href="/archives" style="float:right;font-style:italic">A Collection of Essays by <span style="color:blue;">VIVO</span></a>
    </div>
    <br>
</div>
