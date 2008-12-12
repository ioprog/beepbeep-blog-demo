{application, beepbeep_blog_example,
 [{description, "beepbeep_blog_example"},
  {vsn, "0.01"},
  {modules, [
    beepbeep_blog_example,
    beepbeep_blog_example_app,
    beepbeep_blog_example_sup,
    beepbeep_blog_example_deps
  ]},
  {registered, []},
  {mod, {beepbeep_blog_example_app, []}},
  {env, []},
  {applications, [kernel, stdlib, crypto]}]}.
