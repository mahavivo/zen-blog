% rebase('base.tpl', title='Page Title')
<br>

<div class="card border-0">
  <img class="card-img-top" src="/images/{{image}}" alt="Card image cap">
%end
  <div class="card-block" style="font-family:PingFangSC,Arial,'Hiragino Sans GB';">
    <h4 class="card-title text-center" style="margin:30px;">{{title}}</h4>
    <p class="card-text" style="white-space: pre-line;">{{!content}}</p>
    <p class="card-text text-muted text-right">{{date}}</p>
  </div>

</div>