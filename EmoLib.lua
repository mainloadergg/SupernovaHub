--[[
    EmoLib v8.1 - MM2 Style UI Library
    Embeddable | CreateWindow API | Lucide icons | Reflectance | Multi dropdown
    v8.1: Slider/Input com Increment (aliases: Increase, Step), padrao 0.1
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local TextService = game:GetService("TextService")

local Camera = workspace.CurrentCamera

local EmoLib = {
    Version = "8.1.0",
    Windows = {},
}

local DEFAULTS = {
    HeaderTexture = "rbxassetid://6927295847",
    AccentColor = Color3.fromRGB(180, 30, 30),
    BackgroundColor = Color3.fromRGB(12, 12, 12),
    SidebarColor = Color3.fromRGB(8, 8, 8),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(160, 160, 160),
    StrokeColor = Color3.fromRGB(40, 40, 40),
    Font = Enum.Font.GothamBold,
    FontRegular = Enum.Font.Gotham,
    Margin = 10,
    DragThreshold = 14,
    FloatBtnSpin = false,
    FloatBtnTransparency = 0.15,
    ClickSound = nil,
    ReflectanceEffect = true,
    Title = "EmoLib",
    SubTitle = "MM2 Style UI",
}

local Icons = {
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-container"] = "rbxassetid://17466205552",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-todo"] = "rbxassetid://17376008003",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://10734920149",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-plane-landing"] = "rbxassetid://17376029914",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
	["lucide-cat"] = "rbxassetid://16935650691",
	["lucide-message-circle-question"] = "rbxassetid://16970049192",
	["lucide-webhook"] = "rbxassetid://17320556264",
}

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then obj[k] = v end
    end
    if props and props.Parent then obj.Parent = props.Parent end
    return obj
end

local function Tween(obj, props, time, style, dir)
    local t = TweenService:Create(obj, TweenInfo.new(time or 0.22, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function GetViewport()
    return Camera.ViewportSize
end

-- Measures wrapped text height for a given width (used for deterministic row sizing)
local function MeasureHeight(text, size, font, width)
    if width < 20 then return size + 2 end
    local ok, result = pcall(function()
        return TextService:GetTextSize(text, size, font, Vector2.new(width, 10000))
    end)
    if ok and result then return math.ceil(result.Y) end
    return size + 2
end

-- Conta casas decimais de um numero (ex: 0.25 -> 2, 1 -> 0)
local function CountDecimals(n)
    n = tonumber(n) or 0
    local s = string.format("%.10f", n):gsub("0+$", "")
    local d = s:match("%.(%d+)")
    return d and #d or 0
end

-- Encaixa o valor no passo (Increment), respeita Min/Max e limpa o float
local function SnapValue(v, min, max, inc)
    inc = tonumber(inc) or 0
    if inc > 0 then
        v = min + math.floor((v - min) / inc + 0.5) * inc
    end
    v = math.clamp(v, min, max)
    local dec = math.max(CountDecimals(inc), CountDecimals(min))
    local m = 10 ^ dec
    return math.floor(v * m + 0.5) / m
end

local AssetQueue = {
    Pending = 0,
    Total = 0,
    Done = 0,
    Listeners = {},
}

local function AssetNotify()
    for _, fn in ipairs(AssetQueue.Listeners) do
        pcall(fn, AssetQueue.Done, AssetQueue.Total, AssetQueue.Pending)
    end
end

function EmoLib:GetIcon(Name)
    if Name == nil then return nil end
    Name = tostring(Name)
    if string.find(Name, "rbxassetid://", 1, true) or string.find(Name, "rbxasset://", 1, true) then
        return Name
    end
    local AssetId = tonumber(Name)
    if AssetId then return "rbxassetid://" .. AssetId end
    if string.find(Name, "http://", 1, true) == 1 or string.find(Name, "https://", 1, true) == 1 then
        local ok, data = pcall(function()
            if isfolder and not isfolder("EmoLib") then makefolder("EmoLib") end
            if isfolder and not isfolder("EmoLib/Assets") then makefolder("EmoLib/Assets") end
            local hash = tostring(#Name) .. "_" .. string.gsub(Name, "[^%w]", ""):sub(-24)
            local path = "EmoLib/Assets/" .. hash .. ".png"
            if isfile and isfile(path) then
                return getcustomasset and getcustomasset(path) or path
            end
            AssetQueue.Pending += 1
            AssetQueue.Total += 1
            AssetNotify()
            local body
            local okDownload, result = pcall(function()
                if request or http_request or (syn and syn.request) then
                    local req = request or http_request or syn.request
                    local res = req({ Url = Name, Method = "GET" })
                    return res and (res.Body or res.body)
                elseif game.HttpGet then
                    return game:HttpGet(Name)
                end
                return nil
            end)
            body = okDownload and result or nil
            AssetQueue.Pending = math.max(0, AssetQueue.Pending - 1)
            AssetQueue.Done += 1
            AssetNotify()
            if body and writefile then
                writefile(path, body)
                if getcustomasset then return getcustomasset(path) end
            end
            return Name
        end)
        if ok and data then return data end
        return Name
    end
    local key = Name
    if not string.find(key, "lucide-", 1, true) then key = "lucide-" .. Name end
    if Icons[key] then return Icons[key] end
    if Icons[Name] then return Icons[Name] end
    return nil
end

local function ApplyStudTexture(parent, transparency, cornerRadius)
    transparency = transparency or 0.55
    cornerRadius = cornerRadius or 6
    local existing = parent:FindFirstChild("_StudTexture")
    if existing then existing:Destroy() end
    local img = Create("ImageLabel", {
        Name = "_StudTexture", Parent = parent, BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1), Image = DEFAULTS.HeaderTexture,
        ImageTransparency = transparency, ScaleType = Enum.ScaleType.Crop, ZIndex = 0,
    })
    Create("UICorner", {Parent = img, CornerRadius = UDim.new(0, cornerRadius)})
    return img
end

local function MakeShine(Host, CornerRadius, Intensity, enabled)
    if not Host or not enabled then return nil end
    CornerRadius = CornerRadius or 6
    local strong = Intensity == "strong"
    local old = Host:FindFirstChild("EmoShine")
    if old then old:Destroy() end

    local clip = Create("Frame", {
        Name = "EmoShine", Parent = Host, BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1), ZIndex = 20, ClipsDescendants = true, Active = false,
    })
    Create("UICorner", {Parent = clip, CornerRadius = UDim.new(0, CornerRadius)})

    local beam = Create("Frame", {
        Name = "ShineBeam", Parent = clip,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(strong and 0.45 or 0.3, 0, 1, 0),
        Position = UDim2.new(-0.2, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 140, 140),
        BackgroundTransparency = strong and 0.55 or 0.82,
        BorderSizePixel = 0, Rotation = 14, Active = false, ZIndex = 21,
    })
    Create("UIGradient", {
        Parent = beam,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.35, strong and 0.45 or 0.7),
            NumberSequenceKeypoint.new(0.5, strong and 0.2 or 0.4),
            NumberSequenceKeypoint.new(0.65, strong and 0.45 or 0.7),
            NumberSequenceKeypoint.new(1, 1),
        }),
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 30, 30)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 230, 230)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 40, 40)),
        }),
    })

    local t0, speed = tick(), strong and 2.8 or 3.8
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not clip.Parent or not beam.Parent then
            pcall(function() conn:Disconnect() end)
            return
        end
        local alpha = ((tick() - t0) % speed) / speed
        beam.Position = UDim2.new(-0.15 + alpha * 1.3, 0, 0.5, 0)
        beam.BackgroundTransparency = (strong and 0.5 or 0.78) + math.sin(alpha * math.pi * 2) * 0.04
    end)
    clip.Destroying:Connect(function() pcall(function() conn:Disconnect() end) end)
    return clip
end

local function MakeDraggable(frame, handle, clickCallback, onDragEnd, threshold)
    handle = handle or frame
    local dragging, dragStart, startPos, moved, activeInput = false, nil, nil, false, nil
    threshold = threshold or 14

    local function IsOurInput(input)
        if not activeInput then return false end
        if activeInput.UserInputType == Enum.UserInputType.Touch then return input == activeInput end
        return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.MouseButton1
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        if dragging then return end
        dragging, moved, activeInput = true, false, input
        dragStart, startPos = input.Position, frame.Position
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging or not IsOurInput(input) then return end
        local delta = input.Position - dragStart
        if not moved then
            if math.abs(delta.X) < threshold and math.abs(delta.Y) < threshold then return end
            moved = true
        end
        local newX = startPos.X.Offset + delta.X
        local newY = startPos.Y.Offset + delta.Y
        if startPos.X.Scale ~= 0 or startPos.Y.Scale ~= 0 then
            local vp = GetViewport()
            newX = startPos.X.Scale * vp.X + startPos.X.Offset + delta.X
            newY = startPos.Y.Scale * vp.Y + startPos.Y.Offset + delta.Y
        end
        local vp = GetViewport()
        local sx, sy = math.max(frame.AbsoluteSize.X, 1), math.max(frame.AbsoluteSize.Y, 1)
        local margin = DEFAULTS.Margin
        newX = math.clamp(newX, margin, math.max(margin, vp.X - sx - margin))
        newY = math.clamp(newY, margin, math.max(margin, vp.Y - sy - margin))
        frame.Position = UDim2.fromOffset(newX, newY)
    end)

    UserInputService.InputEnded:Connect(function(input)
        if not dragging then return end
        if activeInput and activeInput.UserInputType == Enum.UserInputType.Touch then
            if input ~= activeInput then return end
        elseif input.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end
        local wasDrag = moved
        dragging, activeInput = false, nil
        if wasDrag then
            if onDragEnd then onDragEnd() end
        else
            if clickCallback then clickCallback() end
        end
    end)
end


-- ========== NOTIFICATIONS (Genesis-style animation, EmoLib design) ==========
local NotifyState = {
    Gui = nil,
    Holder = nil,
}

local function EnsureNotifyGui()
    if NotifyState.Gui and NotifyState.Gui.Parent then
        return NotifyState.Holder
    end
    local parent = (gethui and gethui()) or CoreGui
    local existing = parent:FindFirstChild("EmoLib_Notifications")
    if existing then existing:Destroy() end

    local gui = Create("ScreenGui", {
        Name = "EmoLib_Notifications",
        Parent = parent,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 2147483647,
        IgnoreGuiInset = true,
    })
    local holder = Create("Frame", {
        Parent = gui,
        Position = UDim2.new(1, -18, 1, -18),
        Size = UDim2.new(0, 320, 1, -36),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 100,
    })
    Create("UIListLayout", {
        Parent = holder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 10),
    })
    NotifyState.Gui = gui
    NotifyState.Holder = holder
    return holder
end

function EmoLib:Notify(config)
    if type(config) ~= "table" then
        config = { Title = "Notification", Content = tostring(config or "") }
    end
    local title = config.Title or "Notification"
    local content = config.Content or config.Description or ""
    local subContent = config.SubContent or config.Subtitle or ""
    local duration = config.Duration
    local accent = config.AccentColor or DEFAULTS.AccentColor

    local holder = EnsureNotifyGui()

    local slot = Create("Frame", {
        Parent = holder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = false,
    })

    local root = Create("Frame", {
        Parent = slot,
        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
        BackgroundTransparency = 0.05,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(1, 60, 0, 0),
        ZIndex = 101,
        ClipsDescendants = true,
    })
    Create("UICorner", {Parent = root, CornerRadius = UDim.new(0, 6)})
    Create("UIStroke", {
        Parent = root, Color = accent, Thickness = 1, Transparency = 0.4,
    })
    ApplyStudTexture(root, 0.75, 6)

    -- left accent bar
    Create("Frame", {
        Parent = root,
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 1, 0),
        Position = UDim2.fromOffset(0, 0),
        ZIndex = 102,
    })

    local titleL = Create("TextLabel", {
        Parent = root,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(16, 12),
        Size = UDim2.new(1, -48, 0, 18),
        Font = DEFAULTS.Font,
        Text = title,
        TextColor3 = DEFAULTS.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 103,
    })

    local closeBtn = Create("ImageButton", {
        Parent = root,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(16, 16),
        Position = UDim2.new(1, -28, 0, 14),
        Image = EmoLib:GetIcon("x") or "rbxassetid://10747384394",
        ImageColor3 = Color3.fromRGB(180, 80, 80),
        ZIndex = 104,
    })

    local body = Create("Frame", {
        Parent = root,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(16, 34),
        Size = UDim2.new(1, -28, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 103,
    })
    Create("UIListLayout", {
        Parent = body,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
    })
    Create("UIPadding", {
        Parent = body,
        PaddingBottom = UDim.new(0, 14),
    })

    if content ~= "" then
        Create("TextLabel", {
            Parent = body,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = DEFAULTS.FontRegular,
            Text = content,
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 13,
            TextTransparency = 0.08,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            ZIndex = 103,
        })
    end
    if subContent ~= "" then
        Create("TextLabel", {
            Parent = body,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = DEFAULTS.FontRegular,
            Text = subContent,
            TextColor3 = DEFAULTS.SubTextColor,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            ZIndex = 103,
        })
    end

    local closed = false
    local function Open()
        task.defer(function()
            local h = math.max(root.AbsoluteSize.Y, 54)
            slot.Size = UDim2.new(1, 0, 0, h)
            -- Genesis-style: slide in from right (offset 60 -> 0)
            Tween(root, {Position = UDim2.new(0, 0, 0, 0)}, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        end)
    end

    local function Close()
        if closed then return end
        closed = true
        Tween(root, {Position = UDim2.new(1, 60, 0, 0)}, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.38, function()
            if slot and slot.Parent then slot:Destroy() end
        end)
    end

    closeBtn.MouseButton1Click:Connect(Close)
    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, {ImageColor3 = Color3.fromRGB(255, 100, 100)}, 0.12)
    end)
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, {ImageColor3 = Color3.fromRGB(180, 80, 80)}, 0.12)
    end)

    Open()
    if duration and duration > 0 then
        task.delay(duration, Close)
    end

    return {
        Close = Close,
        SetTitle = function(_, t) titleL.Text = t end,
    }
end


function EmoLib:CreateWindow(config)
    config = config or {}
    for k, v in pairs(DEFAULTS) do
        if config[k] == nil then config[k] = v end
    end

    local ClickSoundObj = nil
    local function PlayClick()
        if not config.ClickSound or config.ClickSound == "" or config.ClickSound == 0 then return end
        pcall(function()
            if not ClickSoundObj then
                ClickSoundObj = Instance.new("Sound")
                ClickSoundObj.Name = "EmoClick"
                ClickSoundObj.Volume = 0.35
                ClickSoundObj.Parent = SoundService
            end
            local id = tostring(config.ClickSound)
            if not string.find(id, "rbxassetid://") then id = "rbxassetid://" .. id end
            ClickSoundObj.SoundId = id
            ClickSoundObj:Play()
        end)
    end

    pcall(function()
        local parent = (gethui and gethui()) or CoreGui
        if parent:FindFirstChild("EmoLib") then parent.EmoLib:Destroy() end
    end)

    local ScreenGui = Create("ScreenGui", {
        Name = "EmoLib",
        Parent = (gethui and gethui()) or CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 2147483646,
    })

    local function GetUISize()
        local vp = GetViewport()
        -- nunca deixa a janela maior que a tela (DPI baixo / celular): o
        -- minimo e' limitado pelo maximo disponivel
        local maxW = math.max(280, vp.X - 24)
        local maxH = math.max(220, vp.Y - 24)
        local w = math.clamp(math.floor(vp.X * 0.62), math.min(560, maxW), maxW)
        local h = math.clamp(math.floor(vp.Y * 0.68), math.min(400, maxH), maxH)
        return UDim2.fromOffset(w, h)
    end

    local Main = Create("CanvasGroup", {
        Name = "Main", Parent = ScreenGui,
        BackgroundColor3 = config.BackgroundColor, BackgroundTransparency = 0,
        BorderSizePixel = 0, Size = GetUISize(), Position = UDim2.fromOffset(0, 0),
        AnchorPoint = Vector2.new(0, 0), ClipsDescendants = true, GroupTransparency = 1,
    })
    Create("UICorner", {Parent = Main, CornerRadius = UDim.new(0, 6)})
    local MainStroke = Create("UIStroke", {
        Parent = Main, Color = Color3.fromRGB(30, 30, 30), Thickness = 1, Transparency = 0.3,
    })
    ApplyStudTexture(Main, 0.72, 6)
    if config.ReflectanceEffect then
        task.defer(function() MakeShine(Main, 6, "normal", true) end)
    end

    local function CenterMain()
        local vp = GetViewport()
        local w, h = Main.AbsoluteSize.X, Main.AbsoluteSize.Y
        if w < 10 then w = 600 end
        if h < 10 then h = 420 end
        local x = math.clamp(math.floor((vp.X - w) / 2), config.Margin, math.max(config.Margin, vp.X - w - config.Margin))
        local y = math.clamp(math.floor((vp.Y - h) / 2), config.Margin, math.max(config.Margin, vp.Y - h - config.Margin))
        Main.Position = UDim2.fromOffset(x, y)
    end

    -- Fade: stroke first, then body (Genesis-like clean fade)
    local function FadeInMain()
        MainStroke.Transparency = 1
        Main.GroupTransparency = 1
        Tween(MainStroke, {Transparency = 0.3}, 0.12)
        task.delay(0.08, function()
            Tween(Main, {GroupTransparency = 0}, 0.25)
        end)
    end

    local function FadeOutMain(callback)
        -- borders disappear first
        Tween(MainStroke, {Transparency = 1}, 0.12)
        task.delay(0.1, function()
            Tween(Main, {GroupTransparency = 1}, 0.22)
            task.wait(0.24)
            if callback then callback() end
        end)
    end

    local function FadeOutAndDestroy()
        PlayClick()
        FadeOutMain(function()
            ScreenGui:Destroy()
        end)
    end

    -- Loading overlay (black screen while URL assets download)
    local LoadOverlay = Create("Frame", {
        Name = "LoadOverlay", Parent = ScreenGui,
        Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = 900,
    })
    local LoadTitle = Create("TextLabel", {
        Parent = LoadOverlay, BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.42, 0),
        Size = UDim2.fromOffset(400, 28), Font = config.Font,
        Text = "Downloading Assets", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 901,
    })
    local LoadSub = Create("TextLabel", {
        Parent = LoadOverlay, BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.42, 28),
        Size = UDim2.fromOffset(400, 20), Font = config.FontRegular,
        Text = "Adding the finishing touches", TextColor3 = Color3.fromRGB(160, 160, 160),
        TextSize = 13, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 901,
    })
    local BarBg = Create("Frame", {
        Parent = LoadOverlay, AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.42, 58), Size = UDim2.fromOffset(260, 6),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, ZIndex = 901,
    })
    Create("UICorner", {Parent = BarBg, CornerRadius = UDim.new(1, 0)})
    local BarFill = Create("Frame", {
        Parent = BarBg, BackgroundColor3 = config.AccentColor,
        Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, ZIndex = 902,
    })
    Create("UICorner", {Parent = BarFill, CornerRadius = UDim.new(1, 0)})
    local LoadPct = Create("TextLabel", {
        Parent = LoadOverlay, BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.42, 78),
        Size = UDim2.fromOffset(200, 18), Font = config.FontRegular,
        Text = "0%", TextColor3 = Color3.fromRGB(180, 180, 180),
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 901,
    })

    local loadFinished = false
    local function UpdateLoadBar(done, total, pending)
        if loadFinished then return end
        local pct = 0
        if total > 0 then
            pct = math.clamp(done / total, 0, 1)
        else
            pct = 1
        end
        Tween(BarFill, {Size = UDim2.fromScale(pct, 1)}, 0.15)
        LoadPct.Text = string.format("%d%%", math.floor(pct * 100))
        if total > 0 and pending == 0 and done >= total then
            loadFinished = true
            LoadTitle.Text = "Adding the finishing touches"
            LoadSub.Text = "Almost ready..."
            task.delay(0.35, function()
                Tween(LoadOverlay, {BackgroundTransparency = 1}, 0.35)
                Tween(LoadTitle, {TextTransparency = 1}, 0.3)
                Tween(LoadSub, {TextTransparency = 1}, 0.3)
                Tween(BarBg, {BackgroundTransparency = 1}, 0.3)
                Tween(BarFill, {BackgroundTransparency = 1}, 0.3)
                Tween(LoadPct, {TextTransparency = 1}, 0.3)
                task.wait(0.35)
                LoadOverlay:Destroy()
                CenterMain()
                FadeInMain()
            end)
        end
    end
    table.insert(AssetQueue.Listeners, UpdateLoadBar)

    task.spawn(function()
        for _ = 1, 15 do
            if Main.AbsoluteSize.X > 10 then break end
            task.wait(0.04)
        end
        CenterMain()
        -- wait a short moment for any immediate GetIcon URL calls during tab build
        task.wait(0.15)
        if AssetQueue.Total == 0 then
            -- no downloads needed
            loadFinished = true
            Tween(BarFill, {Size = UDim2.fromScale(1, 1)}, 0.2)
            LoadPct.Text = "100%"
            LoadTitle.Text = "Adding the finishing touches"
            task.wait(0.25)
            Tween(LoadOverlay, {BackgroundTransparency = 1}, 0.35)
            Tween(LoadTitle, {TextTransparency = 1}, 0.3)
            Tween(LoadSub, {TextTransparency = 1}, 0.3)
            Tween(BarBg, {BackgroundTransparency = 1}, 0.3)
            Tween(BarFill, {BackgroundTransparency = 1}, 0.3)
            Tween(LoadPct, {TextTransparency = 1}, 0.3)
            task.wait(0.35)
            if LoadOverlay.Parent then LoadOverlay:Destroy() end
            FadeInMain()
        else
            UpdateLoadBar(AssetQueue.Done, AssetQueue.Total, AssetQueue.Pending)
            -- safety timeout 15s
            local t0 = tick()
            while not loadFinished and tick() - t0 < 15 do
                task.wait(0.1)
            end
            if not loadFinished then
                loadFinished = true
                if LoadOverlay.Parent then
                    Tween(LoadOverlay, {BackgroundTransparency = 1}, 0.3)
                    task.wait(0.3)
                    LoadOverlay:Destroy()
                end
                FadeInMain()
            end
        end
    end)

    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        Main.Size = GetUISize()
        task.defer(CenterMain)
    end)

    local function ShowDialog(title, message, onConfirm, onCancel)
        PlayClick()
        local overlay = Create("TextButton", {
            Name = "EmoDialog", Parent = ScreenGui, Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1,
            Text = "", AutoButtonColor = false, ZIndex = 500,
        })
        Tween(overlay, {BackgroundTransparency = 0.5}, 0.18)

        local panel = Create("Frame", {
            Parent = overlay, AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.42, 0), Size = UDim2.fromOffset(340, 160),
            BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 1,
            ZIndex = 501, ClipsDescendants = true,
        })
        Create("UICorner", {Parent = panel, CornerRadius = UDim.new(0, 6)})
        local pStroke = Create("UIStroke", {Parent = panel, Color = config.AccentColor, Thickness = 1, Transparency = 1})
        ApplyStudTexture(panel, 0.7, 6)
        Tween(pStroke, {Transparency = 0.35}, 0.1)
        task.delay(0.06, function()
            Tween(panel, {Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 0}, 0.2)
        end)

        Create("TextLabel", {
            Parent = panel, BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 14),
            Size = UDim2.new(1, -36, 0, 22), Font = config.Font, Text = title or "Confirm",
            TextColor3 = config.TextColor, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 502,
        })
        Create("TextLabel", {
            Parent = panel, BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 42),
            Size = UDim2.new(1, -36, 0, 50), Font = config.FontRegular, Text = message or "",
            TextColor3 = config.SubTextColor, TextSize = 13, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 502,
        })

        local function closeDialog(confirmed)
            PlayClick()
            Tween(pStroke, {Transparency = 1}, 0.08)
            task.delay(0.06, function()
                Tween(overlay, {BackgroundTransparency = 1}, 0.14)
                Tween(panel, {Position = UDim2.new(0.5, 0, 0.42, 0), BackgroundTransparency = 1}, 0.14)
                task.wait(0.15)
                overlay:Destroy()
                if confirmed and onConfirm then onConfirm()
                elseif not confirmed and onCancel then onCancel() end
            end)
        end

        local yesBtn = Create("TextButton", {
            Parent = panel, Size = UDim2.fromOffset(120, 32), Position = UDim2.new(1, -140, 1, -44),
            BackgroundColor3 = Color3.fromRGB(14, 14, 14), BackgroundTransparency = 0.1,
            Text = "Confirm", Font = config.Font, TextSize = 13, TextColor3 = config.TextColor,
            AutoButtonColor = false, ZIndex = 502,
        })
        Create("UICorner", {Parent = yesBtn, CornerRadius = UDim.new(0, 5)})
        Create("UIStroke", {Parent = yesBtn, Color = config.AccentColor, Thickness = 1.2, Transparency = 0.25})
        yesBtn.MouseButton1Click:Connect(function() closeDialog(true) end)

        local noBtn = Create("TextButton", {
            Parent = panel, Size = UDim2.fromOffset(100, 32), Position = UDim2.new(1, -250, 1, -44),
            BackgroundColor3 = Color3.fromRGB(28, 28, 28), Text = "Cancel", Font = config.Font,
            TextSize = 13, TextColor3 = config.TextColor, AutoButtonColor = false, ZIndex = 502,
        })
        Create("UICorner", {Parent = noBtn, CornerRadius = UDim.new(0, 5)})
        noBtn.MouseButton1Click:Connect(function() closeDialog(false) end)
    end

    -- Header
    local Header = Create("Frame", {
        Name = "Header", Parent = Main, BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 52), ZIndex = 2,
    })
    ApplyStudTexture(Header, 0.45, 0)
    Create("UIGradient", {
        Parent = Header,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 14, 14)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8)),
        }),
        Rotation = 90,
    })

    local Logo = Create("ImageLabel", {
        Name = "Logo", Parent = Header, BackgroundTransparency = 1,
        Size = UDim2.fromOffset(34, 34), Position = UDim2.fromOffset(10, 9),
        Image = EmoLib:GetIcon(config.Logo or "sword") or "rbxassetid://6031097229",
        ScaleType = Enum.ScaleType.Fit, ZIndex = 3,
    })
    Create("UICorner", {Parent = Logo, CornerRadius = UDim.new(0, 4)})

    local TitleLabel = Create("TextLabel", {
        Name = "Title", Parent = Header, BackgroundTransparency = 1,
        Position = UDim2.fromOffset(56, 7), Size = UDim2.new(0, 260, 0, 20),
        Font = config.Font, Text = config.Title, TextColor3 = config.TextColor,
        TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
    })
    local SubTitleLabel = Create("TextLabel", {
        Name = "SubTitle", Parent = Header, BackgroundTransparency = 1,
        Position = UDim2.fromOffset(56, 28), Size = UDim2.new(0, 260, 0, 16),
        Font = config.FontRegular, Text = config.SubTitle, TextColor3 = config.SubTextColor,
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
    })

    local FloatingIcon
    local Window = {
        ScreenGui = ScreenGui,
        Main = Main,
        Config = config,
    }

    local function HeaderButton(icon, pos, callback)
        local btn = Create("ImageButton", {
            Parent = Header, BackgroundTransparency = 1, Size = UDim2.fromOffset(20, 20),
            Position = pos, Image = EmoLib:GetIcon(icon) or "rbxassetid://0",
            ImageColor3 = Color3.fromRGB(200, 60, 60), ScaleType = Enum.ScaleType.Fit, ZIndex = 4,
        })
        btn.MouseEnter:Connect(function() Tween(btn, {ImageColor3 = Color3.fromRGB(255, 90, 90)}, 0.12) end)
        btn.MouseLeave:Connect(function() Tween(btn, {ImageColor3 = Color3.fromRGB(200, 60, 60)}, 0.12) end)
        btn.MouseButton1Click:Connect(function() PlayClick(); if callback then callback() end end)
        return btn
    end

    HeaderButton("x", UDim2.new(1, -30, 0.5, -10), function()
        ShowDialog("Close EmoLib", "Are you sure you want to close and destroy the interface?", function()
            FadeOutAndDestroy()
        end)
    end)

    HeaderButton("minimize", UDim2.new(1, -56, 0.5, -10), function()
        Tween(MainStroke, {Transparency = 1}, 0.1)
        task.delay(0.08, function()
            Tween(Main, {GroupTransparency = 1}, 0.18)
            task.wait(0.18)
            Main.Visible = false
            if FloatingIcon then
                FloatingIcon.Visible = true
                FloatingIcon.ImageTransparency = 1
                Tween(FloatingIcon, {ImageTransparency = 0}, 0.2)
            end
        end)
    end)

    local function SaveFloatPos()
        pcall(function()
            if type(writefile) ~= "function" then return end
            if isfolder and makefolder and not isfolder("EmoLib") then makefolder("EmoLib") end
            -- a ScreenGui usa IgnoreGuiInset: o espaco do GUI inclui a area
            -- da topbar. Salvar em escala relativa ao ViewportSize gerava um
            -- desvio (aparecia mais acima no reload). Usa o tamanho real da
            -- tela (viewport + inset) pra escala bater certo com o fromScale.
            local GuiService = game:GetService("GuiService")
            local inset = GuiService:GetGuiInset()
            local vs = Camera.ViewportSize
            local screenX = math.max(vs.X, 1)
            local screenY = math.max(vs.Y + inset.Y, 1)
            local abs = FloatingIcon.AbsolutePosition
            writefile("EmoLib/float_pos.json", HttpService:JSONEncode({
                x = math.clamp(abs.X / screenX, 0, 0.95),
                y = math.clamp(abs.Y / screenY, 0, 0.90),
            }))
        end)
    end

    HeaderButton("rotate-ccw", UDim2.new(1, -82, 0.5, -10), function()
        ShowDialog("Reset Position", "Reset the floating button position to the side center?", function()
            if FloatingIcon then
                local vp = GetViewport()
                Tween(FloatingIcon, {Position = UDim2.fromOffset(config.Margin + 8, math.floor(vp.Y / 2 - 25))}, 0.25)
                task.defer(SaveFloatPos)
            end
            CenterMain()
        end)
    end)

    MakeDraggable(Main, Header)

    local Sidebar = Create("Frame", {
        Name = "Sidebar", Parent = Main, BackgroundColor3 = config.SidebarColor,
        BorderSizePixel = 0, Size = UDim2.new(0, 170, 1, -52), Position = UDim2.fromOffset(0, 52), ZIndex = 1,
    })
    ApplyStudTexture(Sidebar, 0.78, 0)
    Create("UIStroke", {
        Parent = Sidebar, Color = Color3.fromRGB(25, 25, 25), Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })

    local TabsContainer = Create("ScrollingFrame", {
        Name = "Tabs", Parent = Sidebar, BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 8), Size = UDim2.new(1, 0, 1, -16),
        CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 3,
        ScrollBarImageColor3 = config.AccentColor, BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 2,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    })
    Create("UIListLayout", {
        Parent = TabsContainer, Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,
    })
    Create("UIPadding", {
        Parent = TabsContainer,
        PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7),
    })

    -- Grupos da sidebar: cada secao tem um rotulo + uma lista de abas.
    -- CreateTab sempre cai na secao atual (a ultima criada).
    local currentSectionList = nil

    local function CreateSidebarSection(title)
        local sec = Create("Frame", {
            Name = "Section", Parent = TabsContainer, BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 2,
        })
        Create("TextLabel", {
            Name = "Label", Parent = sec, BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 14),
            Font = config.Font, Text = string.upper(tostring(title or "SECTION")),
            TextColor3 = Color3.fromRGB(150, 45, 45), TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2,
        })
        local list = Create("Frame", {
            Name = "List", Parent = sec, BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, 18), Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 2,
        })
        Create("UIListLayout", {
            Parent = list, Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })
        currentSectionList = list
        return list
    end

    local Content = Create("Frame", {
        Name = "Content", Parent = Main, BackgroundColor3 = Color3.fromRGB(8, 8, 8),
        BorderSizePixel = 0, Size = UDim2.new(1, -170, 1, -52), Position = UDim2.fromOffset(170, 52),
        ClipsDescendants = true, ZIndex = 1,
    })
    ApplyStudTexture(Content, 0.82, 0)

    local ContentScroll = Create("ScrollingFrame", {
        Name = "Scroll", Parent = Content, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 4,
        ScrollBarImageColor3 = config.AccentColor, BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 2,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    })
    Create("UIListLayout", {
        Parent = ContentScroll, Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,
    })
    Create("UIPadding", {
        Parent = ContentScroll, PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 16),
        PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12),
    })

    local Tabs, CurrentTab = {}, nil

    -- ========== ROW BUILDER ==========
    -- Every element (toggle, button, input, dropdown) is built on this.
    -- Height is computed from the measured text (no AutomaticSize / no centered
    -- list alignment), so rows never stretch: no description = compact row.
    -- rightWidth reserves space on the right for the control; text wraps before it.
    local ROW_MIN, ROW_PAD, ROW_GAP = 38, 10, 2

    local function BuildRow(page, name, title, subtitle, rightWidth)
        rightWidth = rightWidth or 0
        local frame = Create("Frame", {
            Name = name, Parent = page, BackgroundColor3 = Color3.fromRGB(14, 14, 14),
            Size = UDim2.new(1, 0, 0, ROW_MIN), BorderSizePixel = 0,
        })
        Create("UICorner", {Parent = frame, CornerRadius = UDim.new(0, 5)})
        Create("UIStroke", {Parent = frame, Color = config.StrokeColor, Thickness = 1, Transparency = 0.5})

        local holder = Create("Frame", {
            Parent = frame, BackgroundTransparency = 1,
            Position = UDim2.fromOffset(12, 0),
            Size = UDim2.new(1, -(24 + (rightWidth > 0 and (rightWidth + 10) or 0)), 1, 0),
        })
        local titleL = Create("TextLabel", {
            Parent = holder, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16),
            Font = config.Font, Text = title or "", TextColor3 = config.TextColor, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
        })
        local subL = Create("TextLabel", {
            Parent = holder, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 12),
            Font = config.FontRegular, Text = subtitle or "", TextColor3 = config.SubTextColor, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true, Visible = (subtitle ~= nil and subtitle ~= ""),
        })

        local row = {Frame = frame}
        local lastWidth = -1

        local function Relayout(force)
            local w = holder.AbsoluteSize.X
            if w < 20 then return end
            if w == lastWidth and not force then return end
            lastWidth = w
            local th = MeasureHeight(titleL.Text, 13, config.Font, w)
            local hasDesc = subL.Text ~= ""
            local sh = hasDesc and MeasureHeight(subL.Text, 11, config.FontRegular, w) or 0
            local content = th + (hasDesc and (ROW_GAP + sh) or 0)
            local h = math.max(ROW_MIN, content + ROW_PAD * 2)
            local top = math.floor((h - content) / 2)
            titleL.Position = UDim2.fromOffset(0, top)
            titleL.Size = UDim2.new(1, 0, 0, th)
            subL.Visible = hasDesc
            subL.Position = UDim2.fromOffset(0, top + th + ROW_GAP)
            subL.Size = UDim2.new(1, 0, 0, sh)
            frame.Size = UDim2.new(1, 0, 0, h)
        end

        holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() Relayout(false) end)
        task.defer(function() Relayout(true) end)

        function row.SetTitle(t)
            titleL.Text = t or ""
            Relayout(true)
        end
        function row.SetSubtitle(t)
            subL.Text = t or ""
            Relayout(true)
        end

        return row, frame
    end

    -- ========== TAB + ELEMENTS ==========
    function Window:CreateTab(name, icon)
        if not currentSectionList then
            CreateSidebarSection("NAVIGATION")
        end
        local tabBtn = Create("TextButton", {
            Name = name, Parent = currentSectionList or TabsContainer, BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 34), Text = "", AutoButtonColor = false, ZIndex = 3,
        })
        Create("UICorner", {Parent = tabBtn, CornerRadius = UDim.new(0, 4)})
        Create("UIStroke", {Parent = tabBtn, Color = Color3.fromRGB(45, 45, 45), Thickness = 1, Transparency = 0.4})

        Create("ImageLabel", {
            Name = "Icon", Parent = tabBtn, BackgroundTransparency = 1,
            Size = UDim2.fromOffset(18, 18), Position = UDim2.fromOffset(9, 8),
            Image = EmoLib:GetIcon(icon) or "rbxassetid://0", ImageColor3 = Color3.fromRGB(200, 60, 60),
            ScaleType = Enum.ScaleType.Fit, ZIndex = 4,
        })
        local tabTitle = Create("TextLabel", {
            Name = "Title", Parent = tabBtn, BackgroundTransparency = 1,
            Position = UDim2.fromOffset(34, 0), Size = UDim2.new(1, -42, 1, 0),
            Font = config.Font, Text = name, TextColor3 = Color3.fromRGB(210, 75, 75),
            TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4,
        })
        local page = Create("Frame", {
            Name = name .. "_Page", Parent = ContentScroll, BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0), Visible = false, AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 2,
        })
        Create("UIListLayout", {Parent = page, Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder})

        local Tab = {Button = tabBtn, Page = page, Title = tabTitle, Name = name}

        local function activate()
            PlayClick()
            if CurrentTab then
                CurrentTab.Page.Visible = false
                Tween(CurrentTab.Button, {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}, 0.15)
                CurrentTab.Title.TextColor3 = Color3.fromRGB(210, 75, 75)
            end
            CurrentTab = Tab
            page.Visible = true
            Tween(tabBtn, {BackgroundColor3 = Color3.fromRGB(32, 12, 12)}, 0.15)
            tabTitle.TextColor3 = Color3.fromRGB(255, 110, 110)
        end
        tabBtn.MouseButton1Click:Connect(activate)
        tabBtn.MouseEnter:Connect(function()
            if CurrentTab ~= Tab then Tween(tabBtn, {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}, 0.12) end
        end)
        tabBtn.MouseLeave:Connect(function()
            if CurrentTab ~= Tab then Tween(tabBtn, {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}, 0.12) end
        end)
        table.insert(Tabs, Tab)
        if #Tabs == 1 then task.defer(activate) end

        function Tab:AddSection(text, icon)
            local section = Create("Frame", {Name = "Section", Parent = page, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24)})
            if icon then
                local r = EmoLib:GetIcon(icon)
                if r then
                    Create("ImageLabel", {
                        Parent = section, BackgroundTransparency = 1, Size = UDim2.fromOffset(15, 15),
                        Position = UDim2.fromOffset(0, 4), Image = r, ImageColor3 = config.AccentColor,
                    })
                end
            end
            local label = Create("TextLabel", {
                Parent = section, BackgroundTransparency = 1,
                Position = UDim2.fromOffset(icon and 20 or 0, 0), Size = UDim2.new(1, icon and -20 or 0, 1, 0),
                Font = config.Font, Text = text or "Section", TextColor3 = Color3.fromRGB(180, 50, 50),
                TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
            })
            return {SetText = function(_, t) label.Text = t end}
        end

        function Tab:AddLabel(title, subtitle)
            local frame = Create("Frame", {
                Name = "Label", Parent = page,
                BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = frame, CornerRadius = UDim.new(0, 5)})
            Create("UIStroke", {Parent = frame, Color = config.StrokeColor, Thickness = 1, Transparency = 0.5})

            local holder = Create("Frame", {
                Parent = frame, BackgroundTransparency = 1,
                Position = UDim2.fromOffset(12, 0),
                Size = UDim2.new(1, -24, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
            })
            Create("UIListLayout", {
                Parent = holder, SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 3),
            })
            Create("UIPadding", {
                Parent = holder,
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
            })

            local titleL = Create("TextLabel", {
                Parent = holder, BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                Font = config.Font, Text = title or "Title", TextColor3 = config.TextColor,
                TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true, RichText = true, LayoutOrder = 1,
            })
            local subL = Create("TextLabel", {
                Parent = holder, BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                Font = config.FontRegular, Text = subtitle or "", TextColor3 = config.SubTextColor,
                TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true, RichText = true, LayoutOrder = 2,
                Visible = (subtitle ~= nil and subtitle ~= ""),
            })

            return {
                SetTitle = function(_, t) titleL.Text = t or "" end,
                SetSubtitle = function(_, t)
                    t = t or ""
                    subL.Text = t
                    subL.Visible = (t ~= "")
                end,
                SetText = function(_, t, sub)
                    titleL.Text = t or ""
                    if sub ~= nil then
                        subL.Text = sub
                        subL.Visible = (sub ~= "")
                    end
                end,
            }
        end

        function Tab:AddToggle(cfg)
            if type(cfg) ~= "table" then cfg = {Title = tostring(cfg)} end
            local title = cfg.Title or "Toggle"
            local subtitle = cfg.Description or cfg.Subtitle or ""
            local default, callback = cfg.Default, cfg.Callback

            local row, frame = BuildRow(page, "Toggle", title, subtitle, 40)

            local toggleBg = Create("Frame", {
                Parent = frame,
                BackgroundColor3 = default and config.AccentColor or Color3.fromRGB(40, 40, 40),
                Size = UDim2.fromOffset(40, 20),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = toggleBg, CornerRadius = UDim.new(1, 0)})
            local circle = Create("Frame", {
                Parent = toggleBg, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.fromOffset(14, 14),
                Position = default and UDim2.new(1, -17, 0.5, -7) or UDim2.fromOffset(3, 3),
                BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = circle, CornerRadius = UDim.new(1, 0)})

            local state = default or false
            local function SetState(val, fire)
                state = val
                Tween(toggleBg, {BackgroundColor3 = state and config.AccentColor or Color3.fromRGB(40, 40, 40)}, 0.15)
                Tween(circle, {Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.fromOffset(3, 3)}, 0.15)
                if fire and callback then callback(state) end
            end
            Create("TextButton", {
                Parent = frame, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "", ZIndex = 2,
            }).MouseButton1Click:Connect(function()
                PlayClick(); SetState(not state, true)
            end)

            return {
                SetTitle = function(_, t) row.SetTitle(t) end,
                SetSubtitle = function(_, t) row.SetSubtitle(t) end,
                SetValue = function(_, v) SetState(v, false) end,
                GetValue = function() return state end,
                SetCallback = function(_, cb) callback = cb end,
            }
        end

        function Tab:AddButton(cfg)
            if type(cfg) ~= "table" then cfg = {Title = tostring(cfg)} end
            local title = cfg.Title or "Button"
            local subtitle = cfg.Description or cfg.Subtitle or ""
            local callback = cfg.Callback

            local row, frame = BuildRow(page, "Button", title, subtitle, 14)

            local arrow = Create("ImageLabel", {
                Parent = frame, BackgroundTransparency = 1,
                Size = UDim2.fromOffset(14, 14),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Image = EmoLib:GetIcon("chevron-right") or "rbxassetid://10709791437",
                ImageColor3 = Color3.fromRGB(180, 60, 60),
            })

            local btn = Create("TextButton", {
                Parent = frame, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "", ZIndex = 2,
            })
            btn.MouseEnter:Connect(function()
                Tween(frame, {BackgroundColor3 = Color3.fromRGB(24, 14, 14)}, 0.12)
                Tween(arrow, {ImageColor3 = Color3.fromRGB(255, 90, 90)}, 0.12)
            end)
            btn.MouseLeave:Connect(function()
                Tween(frame, {BackgroundColor3 = Color3.fromRGB(14, 14, 14)}, 0.12)
                Tween(arrow, {ImageColor3 = Color3.fromRGB(180, 60, 60)}, 0.12)
            end)
            btn.MouseButton1Click:Connect(function() PlayClick(); if callback then callback() end end)

            return {
                SetTitle = function(_, t) row.SetTitle(t) end,
                SetSubtitle = function(_, t) row.SetSubtitle(t) end,
                SetCallback = function(_, cb) callback = cb end,
            }
        end

        function Tab:AddSlider(cfg)
            cfg = cfg or {}
            local title, subtitle = cfg.Title or "Slider", cfg.Description or cfg.Subtitle or ""
            local min, max, callback = cfg.Min or 0, cfg.Max or 100, cfg.Callback
            -- passo do slider: Increment (aliases: Increase, Step). Padrao 0.1
            local inc = tonumber(cfg.Increment or cfg.Increase or cfg.Step) or 0.1
            local default = SnapValue(cfg.Default or min, min, max, inc)

            local frame = Create("Frame", {
                Name = "Slider", Parent = page, BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                Size = UDim2.new(1, 0, 0, 60), BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = frame, CornerRadius = UDim.new(0, 5)})
            Create("UIStroke", {Parent = frame, Color = config.StrokeColor, Thickness = 1, Transparency = 0.5})

            local titleL = Create("TextLabel", {
                Parent = frame, BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 10), Size = UDim2.new(1, -78, 0, 16),
                Font = config.Font, Text = title, TextColor3 = config.TextColor, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true,
            })
            local valueL = Create("TextLabel", {
                Parent = frame, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, -12, 0, 10), Size = UDim2.fromOffset(56, 16),
                Font = config.Font, Text = tostring(default), TextColor3 = config.AccentColor, TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top,
            })
            local subL = Create("TextLabel", {
                Parent = frame, BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 28), Size = UDim2.new(1, -24, 0, 12),
                Font = config.FontRegular, Text = subtitle, TextColor3 = config.SubTextColor, TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true,
                Visible = (subtitle ~= ""),
            })
            local barHit = Create("Frame", {
                Parent = frame, BackgroundTransparency = 1,
                Size = UDim2.new(1, -24, 0, 16), Position = UDim2.new(0, 12, 0, 40),
            })
            local barBg = Create("Frame", {
                Parent = barHit, BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(1, 0, 0, 5),
                Position = UDim2.new(0, 0, 0.5, 0), BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = barBg, CornerRadius = UDim.new(1, 0)})
            local barFill = Create("Frame", {
                Parent = barBg, BackgroundColor3 = config.AccentColor,
                Size = UDim2.new((default - min) / math.max(max - min, 1e-9), 0, 1, 0), BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = barFill, CornerRadius = UDim.new(1, 0)})

            local lastWidth = -1
            local function Relayout(force)
                local fw = frame.AbsoluteSize.X
                if fw < 60 then return end
                if fw == lastWidth and not force then return end
                lastWidth = fw
                local th = MeasureHeight(titleL.Text, 13, config.Font, fw - 24 - 62)
                local hasDesc = subL.Text ~= ""
                local sh = hasDesc and MeasureHeight(subL.Text, 11, config.FontRegular, fw - 24) or 0
                local y = 10
                titleL.Position = UDim2.fromOffset(12, y)
                titleL.Size = UDim2.new(1, -78, 0, th)
                valueL.Position = UDim2.new(1, -12, 0, y)
                y = y + th
                subL.Visible = hasDesc
                if hasDesc then
                    y = y + ROW_GAP
                    subL.Position = UDim2.fromOffset(12, y)
                    subL.Size = UDim2.new(1, -24, 0, sh)
                    y = y + sh
                end
                y = y + 6
                barHit.Position = UDim2.new(0, 12, 0, y)
                y = y + 16 + 8
                frame.Size = UDim2.new(1, 0, 0, y)
            end
            frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() Relayout(false) end)
            task.defer(function() Relayout(true) end)

            local sliding, value = false, default

            local function Apply(val, fire)
                local snapped = SnapValue(val, min, max, inc)
                local changed = snapped ~= value
                value = snapped
                barFill.Size = UDim2.new((value - min) / math.max(max - min, 1e-9), 0, 1, 0)
                valueL.Text = tostring(value)
                if fire and changed and callback then callback(value) end
            end

            local function FromInput(input)
                local rel = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / math.max(barBg.AbsoluteSize.X, 1), 0, 1)
                Apply(min + (max - min) * rel, true)
            end

            barHit.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    FromInput(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    FromInput(input)
                end
            end)

            return {
                SetTitle = function(_, t) titleL.Text = t; Relayout(true) end,
                SetSubtitle = function(_, t) subL.Text = t or ""; Relayout(true) end,
                SetValue = function(_, v) Apply(v, false) end,
                GetValue = function() return value end,
                SetCallback = function(_, cb) callback = cb end,
            }
        end

        function Tab:AddInput(cfg)
            cfg = cfg or {}
            local title, subtitle = cfg.Title or "Input", cfg.Description or cfg.Subtitle or ""
            local placeholder, callback, default = cfg.Placeholder or "Type here...", cfg.Callback, cfg.Default or ""
            -- modo numerico: Numeric = true (usa Min, Max e Increment/Increase/Step)
            local numeric = cfg.Numeric == true
            local nMin, nMax = cfg.Min or -math.huge, cfg.Max or math.huge
            local inc = tonumber(cfg.Increment or cfg.Increase or cfg.Step) or 0.1

            local BOX_W = 130
            local row, frame = BuildRow(page, "Input", title, subtitle, BOX_W)

            local box = Create("TextBox", {
                Parent = frame, BackgroundColor3 = Color3.fromRGB(22, 22, 22),
                AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(BOX_W, 28),
                Position = UDim2.new(1, -12, 0.5, 0),
                Font = config.FontRegular, Text = tostring(default), PlaceholderText = placeholder,
                PlaceholderColor3 = Color3.fromRGB(100, 100, 100), TextColor3 = config.TextColor,
                TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false,
                BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 2,
            })
            Create("UICorner", {Parent = box, CornerRadius = UDim.new(0, 5)})
            Create("UIPadding", {Parent = box, PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})
            local boxStroke = Create("UIStroke", {Parent = box, Color = Color3.fromRGB(50, 50, 50), Thickness = 1, Transparency = 0.3})

            local lastValid = tostring(default)

            box.Focused:Connect(function()
                Tween(boxStroke, {Color = config.AccentColor, Transparency = 0}, 0.12)
            end)
            box.FocusLost:Connect(function(enter)
                Tween(boxStroke, {Color = Color3.fromRGB(50, 50, 50), Transparency = 0.3}, 0.12)
                if numeric then
                    local n = tonumber(box.Text)
                    if n then
                        local lo = nMin == -math.huge and -1e18 or nMin
                        local hi = nMax == math.huge and 1e18 or nMax
                        n = SnapValue(n, lo, hi, inc)
                        box.Text = tostring(n)
                        lastValid = box.Text
                        if callback then callback(n, enter) end
                    else
                        box.Text = lastValid
                    end
                    return
                end
                if callback then callback(box.Text, enter) end
            end)

            return {
                SetTitle = function(_, t) row.SetTitle(t) end,
                SetSubtitle = function(_, t) row.SetSubtitle(t) end,
                SetText = function(_, t) box.Text = t; lastValid = tostring(t) end,
                GetText = function() return box.Text end,
                GetValue = function()
                    if numeric then return tonumber(box.Text) end
                    return box.Text
                end,
                SetCallback = function(_, cb) callback = cb end,
            }
        end

        function Tab:AddDropdown(cfg)
            cfg = cfg or {}
            local title = cfg.Title or "Dropdown"
            local subtitle = cfg.Description or cfg.Subtitle or ""
            local options = cfg.Values or cfg.Options or {"Option 1", "Option 2"}
            local multi, multiMax = cfg.Multi == true, tonumber(cfg.MultiMax) or math.huge
            local callback, default = cfg.Callback, cfg.Default

            local function OptName(opt)
                if type(opt) == "table" then
                    return tostring(opt.Name or opt[1] or "")
                end
                return tostring(opt)
            end

            local function OptIcon(opt)
                if type(opt) == "table" then
                    local ic = opt.Icon
                    if type(ic) == "string" and ic ~= "" then
                        return EmoLib:GetIcon(ic)
                    end
                end
                return nil
            end

            local selected
            if multi then
                selected = {}
                if type(default) == "table" then
                    for _, v in ipairs(default) do selected[tostring(v)] = true end
                elseif default then
                    selected[tostring(default)] = true
                end
            else
                selected = default and tostring(default) or OptName(options[1])
            end

            local function GetDisplayText()
                if multi then
                    local list = {}
                    for _, opt in ipairs(options) do
                        local n = OptName(opt)
                        if selected[n] then table.insert(list, n) end
                    end
                    if #list == 0 then return "None" end
                    if #list <= 2 then return table.concat(list, ", ") end
                    return list[1] .. " +" .. (#list - 1)
                end
                return tostring(selected)
            end

            local BOX_W = 120
            local row, frame = BuildRow(page, "Dropdown", title, subtitle, BOX_W)

            local valueBox = Create("Frame", {
                Parent = frame, BackgroundColor3 = Color3.fromRGB(22, 22, 22),
                AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(BOX_W, 28),
                Position = UDim2.new(1, -12, 0.5, 0), BorderSizePixel = 0,
            })
            Create("UICorner", {Parent = valueBox, CornerRadius = UDim.new(0, 5)})
            Create("UIStroke", {Parent = valueBox, Color = Color3.fromRGB(50, 50, 50), Thickness = 1, Transparency = 0.3})

            local valueText = Create("TextLabel", {
                Parent = valueBox, BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -28, 1, 0),
                Font = config.FontRegular, Text = GetDisplayText(), TextColor3 = config.TextColor,
                TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            })
            Create("ImageLabel", {
                Parent = valueBox, BackgroundTransparency = 1, Size = UDim2.fromOffset(12, 12),
                Position = UDim2.new(1, -18, 0.5, -6),
                Image = EmoLib:GetIcon("chevron-down") or "rbxassetid://10709790948",
                ImageColor3 = Color3.fromRGB(180, 60, 60),
            })

            local MODAL_W, MODAL_H = 340, 400
            local ModalRoot = Create("TextButton", {
                Name = "DropdownModal", Parent = ScreenGui, Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1,
                Text = "", AutoButtonColor = false, Visible = false, ZIndex = 300,
            })
            local ModalPanel = Create("Frame", {
                Parent = ModalRoot, AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(MODAL_W, MODAL_H),
                BackgroundColor3 = Color3.fromRGB(16, 16, 16), BackgroundTransparency = 0.05,
                ZIndex = 301, ClipsDescendants = true,
            })
            Create("UICorner", {Parent = ModalPanel, CornerRadius = UDim.new(0, 6)})
            local mStroke = Create("UIStroke", {Parent = ModalPanel, Color = config.AccentColor, Thickness = 1.2, Transparency = 0.35})
            ApplyStudTexture(ModalPanel, 0.72, 6)

            Create("TextLabel", {
                Parent = ModalPanel, Text = title, Font = config.Font, TextSize = 15, TextColor3 = config.TextColor,
                TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
                Size = UDim2.new(1, -52, 0, 48), Position = UDim2.fromOffset(16, 0), ZIndex = 303,
            })
            local ModalClose = Create("ImageButton", {
                Parent = ModalPanel, Image = EmoLib:GetIcon("x") or "rbxassetid://10747384394",
                Size = UDim2.fromOffset(16, 16), Position = UDim2.new(1, -28, 0, 24),
                AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1,
                ImageColor3 = config.SubTextColor, ZIndex = 303,
            })
            Create("Frame", {
                Parent = ModalPanel, Size = UDim2.new(1, -24, 0, 1), Position = UDim2.new(0.5, 0, 0, 48),
                AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(55, 55, 55),
                BackgroundTransparency = 0.4, BorderSizePixel = 0, ZIndex = 302,
            })

            local DropdownScroll = Create("ScrollingFrame", {
                Parent = ModalPanel, Size = UDim2.new(1, -12, 1, multi and -104 or -60),
                Position = UDim2.fromOffset(6, 54), BackgroundTransparency = 1, BorderSizePixel = 0,
                ScrollBarThickness = 5, ScrollBarImageColor3 = config.AccentColor,
                CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 302,
                ElasticBehavior = Enum.ElasticBehavior.Never,
                ScrollingDirection = Enum.ScrollingDirection.Y,
            })
            Create("UIListLayout", {Parent = DropdownScroll, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
            Create("UIPadding", {
                Parent = DropdownScroll, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4),
            })

            -- Confirm button (multi): same look as the option rows, black, red text, no accent border
            local confirmBtn
            if multi then
                confirmBtn = Create("TextButton", {
                    Parent = ModalPanel, Size = UDim2.new(1, -20, 0, 34), Position = UDim2.new(0, 10, 1, -44),
                    BackgroundColor3 = Color3.fromRGB(8, 8, 8), BorderSizePixel = 0,
                    Text = "Confirm", Font = config.Font, TextSize = 13, TextColor3 = Color3.fromRGB(220, 70, 70),
                    AutoButtonColor = false, ZIndex = 303,
                })
                Create("UICorner", {Parent = confirmBtn, CornerRadius = UDim.new(0, 5)})
                confirmBtn.MouseEnter:Connect(function()
                    Tween(confirmBtn, {BackgroundColor3 = Color3.fromRGB(20, 12, 12)}, 0.12)
                end)
                confirmBtn.MouseLeave:Connect(function()
                    Tween(confirmBtn, {BackgroundColor3 = Color3.fromRGB(8, 8, 8)}, 0.12)
                end)
            end

            local function CloseModal()
                PlayClick()
                Tween(mStroke, {Transparency = 1}, 0.08)
                task.delay(0.06, function()
                    Tween(ModalRoot, {BackgroundTransparency = 1}, 0.15)
                    Tween(ModalPanel, {Position = UDim2.new(0.5, 0, 0.38, 0), BackgroundTransparency = 1}, 0.15)
                    task.wait(0.16)
                    ModalRoot.Visible = false
                    Main.Visible = true
                    FadeInMain()
                    valueText.Text = GetDisplayText()
                end)
            end

            local function OpenModal()
                PlayClick()
                Main.Visible = false
                ModalRoot.Visible = true
                ModalRoot.BackgroundTransparency = 1
                ModalPanel.Position = UDim2.new(0.5, 0, 0.38, 0)
                ModalPanel.BackgroundTransparency = 1
                mStroke.Transparency = 1
                Tween(ModalRoot, {BackgroundTransparency = 0.5}, 0.18)
                Tween(mStroke, {Transparency = 0.35}, 0.1)
                task.delay(0.06, function()
                    Tween(ModalPanel, {Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 0.05}, 0.2)
                end)
            end

            ModalClose.MouseButton1Click:Connect(CloseModal)
            if not multi then ModalRoot.MouseButton1Click:Connect(CloseModal) end
            if confirmBtn then
                confirmBtn.MouseButton1Click:Connect(function()
                    if callback then
                        local list = {}
                        for _, opt in ipairs(options) do
                            local n = OptName(opt)
                            if selected[n] then table.insert(list, n) end
                        end
                        callback(list)
                    end
                    CloseModal()
                end)
            end

            local optButtons = {}

            local function BuildOptions()
                for _, ch in ipairs(DropdownScroll:GetChildren()) do
                    if ch:IsA("TextButton") then ch:Destroy() end
                end
                table.clear(optButtons)

                for _, opt in ipairs(options) do
                    local name = OptName(opt)
                    local icon = OptIcon(opt)
                    local isOn = multi and (selected[name] == true) or (not multi and selected == name)

                    local optBtn = Create("TextButton", {
                        Parent = DropdownScroll,
                        BackgroundColor3 = isOn and Color3.fromRGB(45, 18, 18) or Color3.fromRGB(24, 24, 24),
                        Size = UDim2.new(1, 0, 0, 34), Text = "", AutoButtonColor = false, ZIndex = 303, BorderSizePixel = 0,
                    })
                    Create("UICorner", {Parent = optBtn, CornerRadius = UDim.new(0, 5)})

                    local leftOffset = 12
                    if icon then
                        Create("ImageLabel", {
                            Parent = optBtn, BackgroundTransparency = 1, Size = UDim2.fromOffset(20, 20),
                            Position = UDim2.fromOffset(10, 7), Image = icon,
                            ScaleType = Enum.ScaleType.Fit, ZIndex = 304,
                        })
                        leftOffset = 38
                    end

                    local check = Create("ImageLabel", {
                        Parent = optBtn, BackgroundTransparency = 1, Size = UDim2.fromOffset(15, 15),
                        Position = multi and UDim2.fromOffset(leftOffset, 9.5) or UDim2.new(1, -26, 0.5, -7.5),
                        Image = EmoLib:GetIcon("check") or "rbxassetid://10709790644",
                        ImageColor3 = config.AccentColor, ImageTransparency = isOn and 0 or 1, ZIndex = 304,
                    })
                    Create("TextLabel", {
                        Parent = optBtn, BackgroundTransparency = 1,
                        Position = UDim2.fromOffset(multi and (leftOffset + 24) or leftOffset, 0),
                        Size = UDim2.new(1, multi and -(leftOffset + 34) or -(leftOffset + 30), 1, 0),
                        Font = config.FontRegular, Text = name, TextColor3 = config.TextColor,
                        TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 304,
                    })
                    optButtons[name] = { Btn = optBtn, Check = check }

                    optBtn.MouseButton1Click:Connect(function()
                        PlayClick()
                        if multi then
                            if selected[name] then
                                selected[name] = nil
                                Tween(optBtn, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, 0.12)
                                Tween(check, {ImageTransparency = 1}, 0.12)
                            else
                                local count = 0
                                for _ in pairs(selected) do count += 1 end
                                if count >= multiMax then return end
                                selected[name] = true
                                Tween(optBtn, {BackgroundColor3 = Color3.fromRGB(45, 18, 18)}, 0.12)
                                Tween(check, {ImageTransparency = 0}, 0.12)
                            end
                            valueText.Text = GetDisplayText()
                        else
                            selected = name
                            for n, data in pairs(optButtons) do
                                local on = (n == name)
                                Tween(data.Btn, {BackgroundColor3 = on and Color3.fromRGB(45, 18, 18) or Color3.fromRGB(24, 24, 24)}, 0.12)
                                Tween(data.Check, {ImageTransparency = on and 0 or 1}, 0.12)
                            end
                            if callback then callback(name) end
                            CloseModal()
                        end
                    end)
                end
            end

            BuildOptions()

            Create("TextButton", {
                Parent = frame, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "", ZIndex = 5,
            }).MouseButton1Click:Connect(OpenModal)

            return {
                SetTitle = function(_, t) row.SetTitle(t) end,
                SetSubtitle = function(_, t) row.SetSubtitle(t) end,
                GetValue = function()
                    if multi then
                        local list = {}
                        for _, opt in ipairs(options) do
                            local n = OptName(opt)
                            if selected[n] then table.insert(list, n) end
                        end
                        return list
                    end
                    return selected
                end,
                SetValue = function(_, v)
                    if multi and type(v) == "table" then
                        selected = {}
                        for _, x in ipairs(v) do selected[tostring(x)] = true end
                    else
                        selected = tostring(v)
                    end
                    for n, data in pairs(optButtons) do
                        local on = multi and (selected[n] == true) or (selected == n)
                        data.Btn.BackgroundColor3 = on and Color3.fromRGB(45, 18, 18) or Color3.fromRGB(24, 24, 24)
                        data.Check.ImageTransparency = on and 0 or 1
                    end
                    valueText.Text = GetDisplayText()
                end,
                Refresh = function(_, newValues)
                    if type(newValues) == "table" then options = newValues end
                    if multi then
                        local valid = {}
                        for _, opt in ipairs(options) do valid[OptName(opt)] = true end
                        for k in pairs(selected) do
                            if not valid[k] then selected[k] = nil end
                        end
                    else
                        local still = false
                        for _, opt in ipairs(options) do
                            if OptName(opt) == selected then still = true break end
                        end
                        if not still then selected = OptName(options[1]) end
                    end
                    BuildOptions()
                    valueText.Text = GetDisplayText()
                end,
            }
        end

        return Tab
    end

    function Window:SetTitle(title, subtitle)
        TitleLabel.Text = title or config.Title
        if subtitle then SubTitleLabel.Text = subtitle end
    end

    function Window:SetLogo(source)
        local r = EmoLib:GetIcon(source)
        if r then Logo.Image = r end
    end

    function Window:CreateSection(title)
        return CreateSidebarSection(title)
    end

    -- alias retrocompativel: a forma antiga passa a criar um grupo de verdade
    function Window:SetSectionName(name)
        return CreateSidebarSection(name)
    end

    function Window:Destroy()
        FadeOutAndDestroy()
    end

    function Window:Minimize()
        Tween(MainStroke, {Transparency = 1}, 0.1)
        task.delay(0.08, function()
            Tween(Main, {GroupTransparency = 1}, 0.18)
            task.wait(0.18)
            Main.Visible = false
            if FloatingIcon then FloatingIcon.Visible = true end
        end)
    end

    function Window:Center()
        CenterMain()
    end

    -- Float button
    local FLOAT_CORNER = 10
    FloatingIcon = Create("ImageButton", {
        Name = "FloatingIcon", Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BackgroundTransparency = config.FloatBtnTransparency,
        Size = UDim2.fromOffset(50, 50),
        Image = EmoLib:GetIcon("sword") or "rbxassetid://6031097229",
        ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.fromOffset(20, 200), Visible = false, ZIndex = 50,
        ClipsDescendants = true,
    })
    Create("UICorner", {Parent = FloatingIcon, CornerRadius = UDim.new(0, FLOAT_CORNER)})
    local FloatStroke = Create("UIStroke", {
        Parent = FloatingIcon, Color = config.AccentColor, Thickness = 1.5, Transparency = 0.3,
    })
    if config.FloatBtnTransparency >= 1 then
        FloatingIcon.BackgroundTransparency = 1
        FloatStroke.Transparency = 1
    end
    if config.ReflectanceEffect then
        task.defer(function() MakeShine(FloatingIcon, FLOAT_CORNER, "strong", true) end)
    end

    local function LoadFloatPos()
        pcall(function()
            if type(isfile) ~= "function" or type(readfile) ~= "function" then return end
            if not isfile("EmoLib/float_pos.json") then return end
            local data = HttpService:JSONDecode(readfile("EmoLib/float_pos.json"))
            if type(data) ~= "table" then return end
            local x, y = tonumber(data.x), tonumber(data.y)
            if x and y then
                FloatingIcon.Position = UDim2.fromScale(math.clamp(x, 0, 0.95), math.clamp(y, 0, 0.95))
            end
        end)
    end
    task.defer(function()
        LoadFloatPos()
        local p = FloatingIcon.Position
        if p.X.Scale == 0 and p.X.Offset == 20 and p.Y.Offset == 200 then
            local vp = GetViewport()
            FloatingIcon.Position = UDim2.fromOffset(config.Margin + 8, math.floor(vp.Y / 2 - 25))
        end
    end)

    if config.FloatBtnSpin then
        task.spawn(function()
            while FloatingIcon and FloatingIcon.Parent do
                FloatingIcon.Rotation = (FloatingIcon.Rotation + 1.2) % 360
                RunService.RenderStepped:Wait()
            end
        end)
    end

    MakeDraggable(FloatingIcon, FloatingIcon, function()
        PlayClick()
        Main.Visible = true
        FloatingIcon.Visible = false
        FadeInMain()
    end, SaveFloatPos)

    function Window:SetFloatingIcon(source)
        local r = EmoLib:GetIcon(source)
        if r then FloatingIcon.Image = r end
    end

    function Window:Notify(cfg)
        return EmoLib:Notify(cfg)
    end

    table.insert(EmoLib.Windows, Window)
    return Window
end

if getgenv then
    getgenv().EmoLib = EmoLib
end

return EmoLib
