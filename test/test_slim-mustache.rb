require 'helper'
require 'slim/mustache'

class TestSlimMustache < TestSlim

  def test_line
      source = %q{
~foo bar baz
}
      assert_html '{{foo}} bar baz', source
    end

  def test_line_two
        source = %q{
~foo bar ~baz
  }
        assert_html '{{foo}} bar {{baz}}', source
  end
  
  def test_dots
            source = %q{
~foo.bar. baz
      }
    assert_html '{{foo.bar}}. baz', source
  end
  
  def test_dots_section
              source = %q{
~#if user.active
  p active
      }
    assert_html '{{#if user.active}}<p>active</p>{{/if}}', source
  end
      
  def test_punctuate
          source = %q{
~foo, bar ~baz: foo
    }
          assert_html '{{foo}}, bar {{baz}}: foo', source
    end


  def test_line_braced
        source = %q{
p ~(foo * bar). baz
  }
        assert_html '<p>{{foo * bar}}. baz</p>', source
  end

  def test_section
    source = %q{
~#foo
  p bar
}
    assert_html '{{#foo}}<p>bar</p>{{/foo}}', source
  end

  def test_each
    source = %q{
~#each products
  h1 product
  | nice
}
    assert_html '{{#each products}}<h1>product</h1>nice{{/each}}', source
  end

  def test_if
      source = %q{
~#if foo
    'bar
  }
      assert_html '{{#if foo}}bar {{/if}}', source
    end

    def test_not
          source = %q{
    ~^barz
        | fooz
      }
          assert_html '{{^barz}}fooz{{/barz}}', source
    end

  def test_ignore
        source = %q{
~#bar
  ~!ignore
   }
        assert_html '{{#bar}}{{! ignore}}{{/bar}}', source
    end

    def test_include
              source = %q{
~>bar
         }
              assert_html '{{> bar}}', source
          end

  def test_inline
      source = %q{
h1 ~title here
  }
      assert_html '<h1>{{title}} here</h1>', source
    end

  def test_inline_two
        source = %q{
h1 ~title here ~name here
    }
    assert_html '<h1>{{title}} here {{name}} here</h1>', source
  end


  def test_attribute
      source = %q{
a href="~link.url" ~link.text
    }
      assert_html '<a href="{{link.url}}">{{link.text}}</a>', source
    end


    def test_interpolate_simple
          source = %q{
    p ~#{hello_world}
        }
          assert_html '<p>{{Hello World from @env}}</p>', source
    end

  def test_interpolate_complex
        source = %q{
  ~(#{'foo' + ' bar'}) baz
      }
        assert_html '{{foo bar}} baz', source
  end

  def test_all
    source = %q{
ul
  ~#each objects
    li
      a href="~link" ~name #{hello_world} and ~another
}
      assert_html '<ul>{{#each objects}}<li><a href="{{link}}">{{name}} Hello World from @env and {{another}}</a></li>{{/each}}</ul>', source
    end


end
