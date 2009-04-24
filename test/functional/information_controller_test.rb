require File.dirname(__FILE__) + '/../test_helper'
require 'rubygems'
require 'xml'

class MylynConnector::InformationControllerTest < ActionController::TestCase

  def setup
    @controller = MylynConnector::InformationController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_version
    get :version
    assert_response :success
    assert_template 'version.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'version'

    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'version'
  end

  protected
  def read_schema name
    schemapath = File.dirname(__FILE__) + '/../schema/' + name + '.xsd';
    schemadoc = XML::Document.file schemapath
    XML::Schema.document schemadoc
  end
end
