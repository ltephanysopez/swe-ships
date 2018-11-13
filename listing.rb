class Listing
    include DataMapper::Resource
    property :id, Serial
    property :title, Text
    property :logo, Text
    property :description, Text
    property :l_url, Text
    property :location, Text
    property :company, Text

end
