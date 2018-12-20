
[repeater id='14' limit="0,1" display_type="news" where="post_status='Published'"]
  <div id="top-alert-bar" class="w-100 bg-secondary text-center">
    <div class="container position-relative py-3">
      [cond type="is" subject="{{alert_destination}}" value="Internal Link"]
      <a class="text-white h5" href="/{{internal_link}}">
        <strong>{{alert_text}}</strong>
      </a>
      [/cond]
      [cond type="is" subject="{{alert_destination}}" value="External Link"]
      <a class="text-white h5" href="{{external_link}}" target="_blank">
        <strong>{{alert_text}}</strong>
      </a>
      [/cond]

      [cond type="is" subject="{{alert_destination}}" value="None"]
      <p class="text-white h5 mb-0"><strong>{{alert_text}}</strong></p>
      [/cond]
      
      <div class="position-absolute top-0 right-0 d-flex align-items-center h-100">
        <i id="alert-close" class="pointer fas fa-times text-white mr-3"></i>
      </div>
    </div>
 </div>
 <!-- If there is custom JS within your Alert -->
 {{post_javascript}}
[/repeater]
