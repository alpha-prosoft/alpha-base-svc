import json

def lambda_handler(event, context):
    print("Event:", json.dumps(event))

    # Check if the user has a 'profile' attribute
    if 'profile' in event['request']['userAttributes']:
        # Split the 'profile' string by comma to get a list of groups
        groups = event['request']['userAttributes']['profile'].split(',')

        # Add the groups to the token's 'groups' claim
        event['response']['claimsOverrideDetails'] = {
            'groupOverrideDetails': {
                'groupsToOverride': groups
            }
        }

    print("Response:", json.dumps(event))
    return event

