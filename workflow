{
  "name": "Question 1",
  "nodes": [
    {
      "parameters": {
        "pollTimes": {
          "item": [
            {
              "mode": "everyMinute"
            }
          ]
        },
        "filters": {}
      },
      "type": "n8n-nodes-base.gmailTrigger",
      "typeVersion": 1.3,
      "position": [
        0,
        0
      ],
      "id": "7bf6e6e6-286e-4356-9b21-eaec08c828d3",
      "name": "Email Trigger",
      "alwaysOutputData": true,
      "credentials": {
        "gmailOAuth2": {
          "id": "4G1hLArVocvE5xw1",
          "name": "Gmail account"
        }
      }
    },
    {
      "parameters": {
        "conditions": {
          "options": {
            "caseSensitive": true,
            "leftValue": "",
            "typeValidation": "strict",
            "version": 2
          },
          "conditions": [
            {
              "id": "f06fdb54-b4a8-43f8-b5c2-d3fcfbf170d6",
              "leftValue": "={{ $json.Subject }}",
              "rightValue": "New Ticket",
              "operator": {
                "type": "string",
                "operation": "equals",
                "name": "filter.operator.equals"
              }
            }
          ],
          "combinator": "and"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.if",
      "typeVersion": 2.2,
      "position": [
        176,
        0
      ],
      "id": "91f2a4bd-e0c3-4411-b1bc-85794dd5f37e",
      "name": "Check Email Subject"
    },
    {
      "parameters": {
        "jsCode": "const data = $input.first().json.snippet\n\n// Use regex to extract each field\nconst customerMatch = data.match(/Customer Name:\\s*([^I]+?)\\s*ID:/);\nconst idMatch = data.match(/ID:\\s*(\\d+)/);\nconst queryMatch = data.match(/Query:\\s*(.*)$/);\n\nreturn {\n  \n    data: {\n      customer: customerMatch ? customerMatch[1].trim() : null,\n      ticketId: idMatch ? idMatch[1].trim() : null,\n      query: queryMatch ? queryMatch[1].trim() : null,\n      date: new Date().toISOString()\n    }\n  }\n;"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        416,
        -16
      ],
      "id": "857cd5dc-7121-4b0e-85a0-2f38e4b52cf1",
      "name": "Extract Relevant Data"
    },
    {
      "parameters": {
        "operation": "append",
        "documentId": {
          "__rl": true,
          "value": "https://docs.google.com/spreadsheets/d/1hQJ1rMkdrXyVffaVcRQRyqK_KvRd80E3TXU9k0nNosI/edit?gid=0#gid=0",
          "mode": "url"
        },
        "sheetName": {
          "__rl": true,
          "value": "https://docs.google.com/spreadsheets/d/1hQJ1rMkdrXyVffaVcRQRyqK_KvRd80E3TXU9k0nNosI/edit?gid=0#gid=0",
          "mode": "url"
        },
        "columns": {
          "mappingMode": "defineBelow",
          "value": {
            "Name": "={{ $json.data.customer }}",
            "ID": "={{ $json.data.ticketId }}",
            "Query": "={{ $json.data.query }}",
            "Date": "={{ $json.data.date }}"
          },
          "matchingColumns": [],
          "schema": [
            {
              "id": "Name",
              "displayName": "Name",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "ID",
              "displayName": "ID",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "Query",
              "displayName": "Query",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "Date",
              "displayName": "Date",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            }
          ],
          "attemptToConvertTypes": false,
          "convertFieldsToString": false
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleSheets",
      "typeVersion": 4.7,
      "position": [
        640,
        -16
      ],
      "id": "ab7900ce-699b-4c0c-976f-8c42edd23a07",
      "name": "Send to Google Sheets",
      "credentials": {
        "googleSheetsOAuth2Api": {
          "id": "AqEo9uF9OqKYDZJw",
          "name": "Google Sheets account 2"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "Email Trigger": {
      "main": [
        [
          {
            "node": "Check Email Subject",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Check Email Subject": {
      "main": [
        [
          {
            "node": "Extract Relevant Data",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Extract Relevant Data": {
      "main": [
        [
          {
            "node": "Send to Google Sheets",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  },
  "active": false,
  "settings": {
    "executionOrder": "v1"
  },
  "versionId": "89300086-79cf-4e52-ae3c-4804c1c8034d",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "a1d9a3e4ae6c7828066e4ea9adbf282c12c49ccd22990ba0eb1b4cf810ff2d47"
  },
  "id": "160zFgGtc2YrtNww",
  "tags": []
}
