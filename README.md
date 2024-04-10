## Geospatial Data Viewer

This project aims to create an application that receives geospatial data from an external system and provides a user
interface to visualize this data.

***

## Task Description
1. Create a new application using the latest Ruby, Rails and Postgres.
2. Create an API controller which will accept a HTTP POST request containing a JSON string. See below for sample JSON.
3. Once the API is called from outside of the application, persist data in the database. Create 2 resources from the JSON: Ticket and
   Excavator. Ticket is the main object and Excavator belongs to Ticket. Attributes that should be persisted in the database for both objects
   are described below. Use Rails attribute naming conventions and appropriate data types.
4. Add a regular controller with index and show HTML views for the tickets with excavator data.
5. Plot DigsiteInfo->WellKnownText info on a map in the ticket show view.

## Models Description

#### Ticket attributes
    RequestNumber
    SequenceNumber
    RequestType
    RequestAction
    DateTimes->ResponseDueDateTime
    ServiceArea->PrimaryServiceAreaCode->SACode
    ServiceArea->AdditionalServiceAreaCodes->SACode
    DigsiteInfo->WellKnownText

#### Excavator attributes
    Excavator->CompanyName
    Excavator->Address (full address including city, zip, etc as one string)
    Excavator->CrewOnSite

## Sample JSON

```json
{
  "ContactCenter":"UPCA",
  "RequestNumber":"09252012-00001",
  "ReferenceRequestNumber":"",
  "VersionNumber":"0",
  "SequenceNumber":"2421",
  "RequestType":"Normal",
  "RequestAction":"Restake",
  "DateTimes":{
    "RequestTakenDateTime":"2011/07/02 23:09:38",
    "TransmissionDateTime":"",
    "LegalDateTime":"2011/07/08 07:00:00",
    "ResponseDueDateTime":"2011/07/13 23:59:59",
    "RestakeDate":"2011/07/21 00:00:00",
    "ExpirationDate":"2011/07/26 00:00:00",
    "LPMeetingAcceptDueDate":"",
    "OverheadBeginDate":"",
    "OverheadEndDate":""
  },
  "ServiceArea":{
    "PrimaryServiceAreaCode":{
      "SACode":"ZZGL103"
    },
    "AdditionalServiceAreaCodes":{
      "SACode":[
        "ZZL01",
        "ZZL02",
        "ZZL03"
      ]
    }
  },
  "Excavator":{
    "CompanyName":"John Doe CONSTRUCTION",
    "Address":"555 Some RD",
    "City":"SOME PARK",
    "State":"ZZ",
    "Zip":"55555",
    "Type":"Excavator",
    "Contact":{
      "Name":"Johnny Doe",
      "Phone":"1115552345",
      "Email":"example@example.com"
    },
    "FieldContact":{
      "Name":"Field Contact",
      "Phone":"1235557924",
      "Email":"example@example.com"
    },
    "CrewOnsite":"true"
  },
  "ExcavationInfo":{
    "TypeOfWork":"rpr man hole tops",
    "WorkDoneFor":"gpc",
    "ProjectDuration":"60 days",
    "ProjectStartDate":"2011/07/08 07:00:00",
    "Explosives":"No",
    "UndergroundOverhead":"Underground",
    "HorizontalBoring":"Road, Driveway, and Sidewalk",
    "Whitelined":"No",
    "LocateInstructions":"locate along the r/o/w on both sides of the rd - including the rd itself - from inter to inter ",
    "Remarks":"Previous Request Number:05161-120-011\n\n\t\t\tPrevious Request Number:06044-254-020\n\n\t\t\tPrevious Request Number:06171-300-030",
    "DigsiteInfo":{
      "LookupBy":"MANUAL",
      "LocationType":"Multiple Address",
      "Subdivision":"",
      "AddressInfo":{
        "State":"ST",
        "County":"COUNTY",
        "Place":"PLACE",
        "Zip":"",
        "Address":{
          "AddressNum":[
            "Address 1",
            "Address 2"
          ]
        },
        "Street":{
          "Prefix":"",
          "Name":"Trinity",
          "Type":"Ave",
          "Suffix":"SW"
        }
      },
      "NearStreet":{
        "State":"XX",
        "County":"SomeCounty",
        "Place":"City",
        "Prefix":"",
        "Name":"",
        "Type":"",
        "Suffix":""
      },
      "Intersection":{
        "ItoI":[
          {
            "State":"XX",
            "County":"FULERTON",
            "Place":"NORCROSS",
            "Prefix":"",
            "Name":"London",
            "Type":"St",
            "Suffix":"SW"
          },
          {
            "State":"ZZ",
            "County":"COUNTY",
            "Place":"ATLANTA",
            "Prefix":"",
            "Name":"Jefferson",
            "Type":"Ave",
            "Suffix":"SW"
          }
        ]
      },
      "WellKnownText":"POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))"
    }
  }
}
```

Давайте разработаем архитектурный план для этого тестового задания, включая необходимые модели данных и миграции для базы данных.

### 1. Модели данных:

#### Ticket (Тикет):
- НомерЗапроса (RequestNumber) - строка
- НомерПоследовательности (SequenceNumber) - строка
- ТипЗапроса (RequestType) - строка
- ДействиеЗапроса (RequestAction) - строка
- ResponseDueDateTime - дата и время
- PrimaryServiceAreaCode - строка
- AdditionalServiceAreaCodes - массив строк
- WellKnownText - текст

#### Excavator (Экскаватор):
- CompanyName - строка
- Address - строка
- CrewOnSite - булево значение

### 2. Миграции:

#### Создание таблицы для Ticket:
```ruby
rails generate migration CreateTickets request_number:string sequence_number:string request_type:string request_action:string response_due_date_time:datetime primary_service_area_code:string additional_service_area_codes:string:text well_known_text:text
```

#### Создание таблицы для Excavator:
```ruby
rails generate migration CreateExcavators company_name:string address:string crew_on_site:boolean
```

### 3. Обработка JSON:

Поля JSON будут сопоставлены с полями моделей следующим образом:

#### Ticket:
- НомерЗапроса (RequestNumber) -> request_number
- НомерПоследовательности (SequenceNumber) -> sequence_number
- ТипЗапроса (RequestType) -> request_type
- ДействиеЗапроса (RequestAction) -> request_action
- DateTimes->ResponseDueDateTime -> response_due_date_time
- ServiceArea->PrimaryServiceAreaCode->SACode -> primary_service_area_code
- ServiceArea->AdditionalServiceAreaCodes->SACode -> additional_service_area_codes
- DigsiteInfo->WellKnownText -> well_known_text

#### Excavator:
- Excavator->CompanyName -> company_name
- Excavator->Address -> address
- Excavator->CrewOnSite -> crew_on_site

### Общий план:

1. Создание моделей Ticket и Excavator.
2. Создание миграций для создания таблиц в базе данных.
3. Обработка POST-запроса в API-контроллере.
4. Извлечение данных из JSON и сохранение их в базе данных, используя модели Ticket и Excavator.
5. Создание обычного контроллера и представлений для отображения данных о тикетах с информацией об экскаваторе.
6. Отображение информации DigsiteInfo->WellKnownText на карте в представлении тикета.
7. Развертывание приложения на хостинге.
