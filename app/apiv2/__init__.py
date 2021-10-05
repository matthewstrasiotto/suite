from flask import Blueprint
import flask_restful

from flask_restful.representations.json import output_json
output_json.__globals__['settings'] = {
    'ensure_ascii': False,
    'encoding': 'utf8'
}

apiv2 = Blueprint('apiv2', __name__, template_folder='templates')
apiv2_rest = flask_restful.Api(apiv2)

from . import routes
