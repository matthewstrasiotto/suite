from flask_restful import Resource
from app.constants import API_ENVELOPE

import pytz


class TimezonesApi(Resource):
    # Pseudo-public
    def get(self):
        """gets all known timezones"""

        return {
            API_ENVELOPE:
            [{"name": timezone} for timezone in pytz.all_timezones]
        }
