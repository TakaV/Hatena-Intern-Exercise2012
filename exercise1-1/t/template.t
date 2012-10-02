use strict;
use warnings;

use Test::More;
use FindBin::libs;

use_ok 'TemplateEngine';

my $template = TemplateEngine->new( file => 'templates/main.html' );
isa_ok $template, 'TemplateEngine';

my $expected = <<'HTML';
<html>
  <head>
    <title>タイトル</title>
  </head>
  <body>
    <p>これはコンテンツです。&amp;&lt;&gt;&quot;</p>
  </body>
</html>
HTML

cmp_ok $template->render({
    title   => 'タイトル',
    content => 'これはコンテンツです。&<>"',
}), 'eq', $expected; 

# テキスト出し分けのテスト
my $expected_shuffle_text = <<'HTML';
<html>
  <head>
    <title>タイトル</title>
  </head>
  <body>
    <p>テキストA&amp;&lt;&gt;&quot;</p>
  </body>
</html>
HTML

cmp_ok $template->render({
    title   => 'タイトル',
    content => [ 'テキストA&<>"' ],
}), 'eq', $expected_shuffle_text; 

my $texts = [ 'テキストA&amp;&lt;&gt;&quot;', 'テキストB&amp;&lt;&gt;&quot;' ];

my $result = $template->render({
    title   => 'タイトル',
    content => [ 'テキストA&<>"', 'テキストB&<>"' ],
});

$result =~ /<p>(.*)<\/p>/;

ok $1 ~~ $texts;

done_testing();
