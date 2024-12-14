create database if not exists account;

use account;

create table if not exists accountClansMounts
(
    id          int auto_increment
        primary key,
    accountId   int not null,
    serverId    int not null,
    mountTypeId int not null,
    mountSkinId int not null
);

create index if not exists accountIndex
    on accountClansMounts (accountId);

create index if not exists accountServerIndex
    on accountClansMounts (serverId);

create index if not exists serverIndex
    on accountClansMounts (serverId);

create index if not exists skinIndex
    on accountClansMounts (mountSkinId);

create index if not exists typeIndex
    on accountClansMounts (mountTypeId);

create table if not exists accountCustomData
(
    accountId    int not null,
    customDataId int not null,
    data         int not null
);

create table if not exists accountFriend
(
    id         int auto_increment
        primary key,
    uuidSource varchar(100) null,
    uuidTarget varchar(100) null,
    status     varchar(100) null,
    favourite  int          not null,
    constraint uuidIndex
        unique (uuidTarget)
);

create table if not exists accountFriendData
(
    accountId int not null,
    status    int not null
);

create table if not exists accountclansmounts
(
    id          int auto_increment
        primary key,
    accountId   int not null,
    serverId    int not null,
    mountTypeId int not null,
    mountSkinId int not null
);

create index if not exists accountIndex
    on accountclansmounts (accountId);

create index if not exists accountServerIndex
    on accountclansmounts (serverId);

create index if not exists serverIndex
    on accountclansmounts (serverId);

create index if not exists skinIndex
    on accountclansmounts (mountSkinId);

create index if not exists typeIndex
    on accountclansmounts (mountTypeId);

create table if not exists accountcustomdata
(
    accountId    int not null,
    customDataId int not null,
    data         int not null
);

create table if not exists accountfriend
(
    id         int auto_increment
        primary key,
    uuidSource varchar(100) null,
    uuidTarget varchar(100) null,
    status     varchar(100) null,
    favourite  int          not null,
    constraint uuidIndex
        unique (uuidTarget)
);

create table if not exists accountfrienddata
(
    accountId int not null,
    status    int not null
);

create table if not exists accountignore
(
    id          int          not null
        primary key,
    uuidIgnorer varchar(100) not null,
    uuidIgnored varchar(100) not null
)
    charset = latin1;

create table if not exists accountpreferences
(
    id                        int auto_increment,
    uuid                      varchar(256)      not null,
    filterChat                tinyint default 1 not null,
    invisibility              tinyint default 0 not null,
    games                     tinyint default 1 not null,
    visibility                tinyint default 1 not null,
    friendChat                tinyint default 1 not null,
    privateMessaging          tinyint default 1 not null,
    showChat                  tinyint default 1 not null,
    partyRequests             tinyint default 1 not null,
    forcefield                tinyint default 0 not null,
    showMacReports            tinyint default 0 not null,
    ignoreVelocity            tinyint default 0 not null,
    pendingFriendRequests     tinyint default 1 not null,
    friendDisplayInventoryUI  tinyint default 1 not null,
    friendDisplayOnlineStatus tinyint default 1 not null,
    friendDisplayServerName   tinyint default 1 not null,
    friendAllowRequests       tinyint default 1 not null,
    friendAllowMessaging      tinyint default 1 not null,
    language                  varchar(45)       null,
    primary key (id, uuid)
)
    charset = latin1;

create table if not exists accounts
(
    id            int auto_increment,
    uuid          varchar(100)                            not null,
    name          varchar(40)                             not null,
    gems          int         default 2500                null,
    gold          int         default 1000                not null,
    coins         int         default 5000                null,
    donorRank     varchar(20)                             null,
    `rank`        varchar(20) default 'ALL'               null,
    rankPerm      tinyint                                 null,
    rankExpire    timestamp   default current_timestamp() not null on update current_timestamp(),
    lastLogin     timestamp   default current_timestamp() not null,
    totalPlayTime tinytext                                null,
    primary key (id, uuid),
    constraint id
        unique (id)
)
    charset = latin1;

create table if not exists accountcointransactions
(
    id        int          not null
        primary key,
    accountId int          not null,
    reason    varchar(100) null,
    coins     int          null,
    constraint accountCoinTransactions_ibfk_1
        foreign key (accountId) references accounts (id)
)
    charset = latin1;

create index if not exists accountId
    on accountcointransactions (accountId);

create table if not exists accountcrowns
(
    accountId  int not null
        primary key,
    crownCount int not null,
    constraint accountcrowns_ibfk_1
        foreign key (accountId) references accounts (id)
);

create table if not exists accountgemtransactions
(
    id        int auto_increment
        primary key,
    accountId int          null,
    reason    varchar(100) null,
    gems      int          null,
    constraint accountGemTransactions_ibfk_1
        foreign key (accountId) references accounts (id)
)
    charset = latin1;

create index if not exists accountId
    on accountgemtransactions (accountId);

create table if not exists accountkits
(
    accountId int                  not null,
    active    tinyint(1) default 0 null,
    kitId     int                  not null,
    constraint accountkits_accounts_null_fk
        foreign key (accountId) references accounts (id)
);

create table if not exists accountkitstats
(
    accountId int not null,
    kitId     int not null,
    statId    int not null,
    value     int not null,
    constraint accountkitstats_accounts_null_fk
        foreign key (accountId) references accounts (id)
);

create table if not exists accountlevelreward
(
    accountId int not null,
    level     int not null,
    constraint accountlevelreward_ibfk_1
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on accountlevelreward (accountId);

create table if not exists accountmissions
(
    accountId int           not null,
    missionId int           not null,
    length    int           not null,
    x         int           not null,
    y         int           not null,
    startTime bigint        not null,
    complete  int default 0 not null,
    progress  int default 0 not null,
    constraint accountmissions_ibfk_1
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on accountmissions (accountId);

create table if not exists accountpunishments
(
    id           int auto_increment
        primary key,
    accountId    int                                    not null,
    target       varchar(16)                            not null,
    category     varchar(100)                           not null,
    sentence     varchar(100)                           not null,
    reason       varchar(100)                           not null,
    duration     double                                 not null,
    admin        varchar(16)                            not null,
    severity     int                                    not null,
    time         timestamp  default current_timestamp() not null,
    removed      tinyint(1) default 0                   not null,
    removeReason varchar(100)                           null,
    removeAdmin  varchar(16)                            null,
    constraint accountpunishments_accounts_null_fk
        foreign key (accountId) references accounts (id)
)
    charset = latin1;

create table if not exists accountranks
(
    id             int auto_increment
        primary key,
    accountId      int         not null,
    rankIdentifier varchar(40) null,
    primaryGroup   tinyint(1)  null,
    constraint additionalIndex
        unique (accountId, rankIdentifier, primaryGroup)
#,
   # constraint accountranks_ibfk_1
   #     foreign key (accountId) references accounts (id)
);

create index if not exists accountIndex
    on accountranks (accountId);

create index if not exists rankIndex
    on accountranks (rankIdentifier);

create table if not exists accountteamspeak
(
    accountId   int      not null
        primary key,
    teamspeakId int      not null,
    linkDate    datetime not null,
    constraint accountTeamspeak_accounts_null_fk
        foreign key (accountId) references accounts (id)
);

create table if not exists accountthanktransactions
(
    id             int                                   not null,
    receiverId     int                                   not null,
    senderId       int                                   not null,
    thankAmount    int       default 0                   not null,
    reason         varchar(32)                           null,
    ignoreCooldown tinyint   default 0                   not null,
    claimed        tinyint   default 0                   not null,
    sentTime       timestamp default current_timestamp() not null,
    claimTime      timestamp                             null
);

create table if not exists accounttitle
(
    accountId int         not null
        primary key,
    trackName varchar(16) not null,
    constraint accountTitle_account
        foreign key (accountId) references accounts (id)
);

create table if not exists accounttreasurehunt
(
    accountId  int not null,
    treasureId int not null,
    primary key (treasureId, accountId),
    constraint accountTreasureHunt_accounts_null_fk
        foreign key (accountId) references accounts (id)
);

create table if not exists activetournaments
(
    name        varchar(100)     not null
        primary key,
    start_date  date             not null,
    end_date    date             not null,
    is_gamemode int              not null,
    server_id   tinyint unsigned not null
)
    charset = latin1;

create table if not exists bonus
(
    accountId      int auto_increment
        primary key,
    dailytime      timestamp     null,
    clansdailytime timestamp     null,
    ranktime       date          null,
    votetime       date          null,
    clansvotetime  date          null,
    dailyStreak    int default 0 null,
    maxDailyStreak int default 0 null,
    voteStreak     int default 0 null,
    maxVoteStreak  int default 0 null,
    tickets        int default 0 null,
    constraint bonus_ibfk_1
        foreign key (accountId) references accounts (id)
);

create table if not exists botspam
(
    id          int auto_increment
        primary key,
    text        varchar(256)  null,
    punishments int           not null,
    enabled     int default 0 not null,
    createdBy   varchar(256)  null,
    enabledBy   varchar(256)  null,
    disabledBy  varchar(256)  null
);

create table if not exists clanBanners
(
    clanId    int          not null
        primary key,
    baseColor varchar(15)  null,
    patterns  varchar(300) null
);

create table if not exists clanBans
(
    uuid         varchar(36) not null,
    admin        varchar(16) not null,
    reason       text        not null,
    banTime      date        not null,
    unbanTime    date        not null,
    permanent    int         not null,
    removed      tinyint(1)  not null,
    removeAdmin  varchar(16) not null,
    removeReason text        not null
);

create table if not exists clanNameBlacklist
(
    clanName varchar(20)                           not null
        primary key,
    admin    varchar(16)                           not null,
    added    timestamp default current_timestamp() not null on update current_timestamp()
);

create table if not exists clanWar
(
    initiatorId int      not null,
    clanId      int      not null,
    score       int      not null,
    created     date     not null,
    lastUpdated date     not null,
    ended       datetime null,
    completed   bit      null
);

create table if not exists clanbanners
(
    clanId    int          not null
        primary key,
    baseColor varchar(15)  null,
    patterns  varchar(300) null
);

create table if not exists clanbans
(
    uuid         varchar(36) not null,
    admin        varchar(16) not null,
    reason       text        not null,
    banTime      date        not null,
    unbanTime    date        not null,
    permanent    int         not null,
    removed      tinyint(1)  not null,
    removeAdmin  varchar(16) not null,
    removeReason text        not null
);

create table if not exists clannameblacklist
(
    clanName varchar(20)                           not null
        primary key,
    admin    varchar(16)                           not null,
    added    timestamp default current_timestamp() not null on update current_timestamp()
);

create table if not exists clans
(
    id             int auto_increment
        primary key,
    serverId       int           not null,
    name           varchar(100)  null,
    description    varchar(140)  null,
    home           varchar(140)  null,
    admin          bit           null,
    dateCreated    datetime      null,
    lastOnline     datetime      null,
    energy         int           null,
    kills          int default 0 not null,
    murder         int default 0 not null,
    deaths         int default 0 not null,
    warWins        int default 0 not null,
    warLosses      int default 0 not null,
    generator      text          null,
    generatorStock int default 0 not null,
    eloRating      int default 0 not null
);

create table if not exists accountclan
(
    id        int auto_increment
        primary key,
    accountId int          null,
    clanId    int          null,
    clanRole  varchar(140) null,
    constraint accountclan_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountclan_ibfk_2
        foreign key (clanId) references clans (id)
);

create index if not exists accountId
    on accountclan (accountId);

create index if not exists clanIdIndex
    on accountclan (clanId);

create table if not exists clanalliances
(
    id          int auto_increment
        primary key,
    clanId      int null,
    otherClanId int null,
    trusted     bit null,
    constraint clanalliances_ibfk_1
        foreign key (otherClanId) references clans (id),
    constraint clanalliances_ibfk_2
        foreign key (clanId) references clans (id)
);

create index if not exists clanIdIndex
    on clanalliances (clanId);

create index if not exists otherClanId
    on clanalliances (otherClanId);

create index if not exists clanName
    on clans (name);

create table if not exists clansIpBans
(
    ipAddress varchar(16) not null
        primary key,
    admin     varchar(40) null
);

create index if not exists adminIndex
    on clansIpBans (admin);

create table if not exists clansIpWhitelists
(
    ipAddress          varchar(16) not null
        primary key,
    admin              varchar(40) null,
    additionalAccounts int         null
);

create index if not exists adminIndex
    on clansIpWhitelists (admin);

create table if not exists clansMountStats
(
    mountId   int          not null
        primary key,
    statToken varchar(256) not null
);

create table if not exists clansNetherPortals
(
    id           int auto_increment
        primary key,
    cornerOne    varchar(30) null,
    cornerTwo    varchar(30) null,
    returnPortal tinyint(1)  null
);

create table if not exists clansOutposts
(
    uniqueId     int         not null
        primary key,
    serverId     int         not null,
    origin       varchar(30) null,
    outpostType  tinyint     not null,
    ownerClan    int         not null,
    timeSpawned  mediumtext  null,
    outpostState tinyint     not null
);

create table if not exists clansSiegeWeapons
(
    uniqueId   int          not null
        primary key,
    serverId   int          not null,
    location   varchar(30)  null,
    ownerClan  int          not null,
    weaponType tinyint      not null,
    health     int          not null,
    yaw        int          not null,
    lastFired  mediumtext   null,
    entities   varchar(200) null
);

create table if not exists clanserver
(
    id         int          not null,
    serverName varchar(100) not null,
    primary key (id, serverName)
)
    charset = latin1;

create table if not exists clansgold
(
    serverId  int not null,
    accountId int not null,
    gold      int not null,
    primary key (serverId, accountId),
    constraint clansgold_ibfk_1
        foreign key (serverId) references clanserver (id),
    constraint clansgold_ibfk_2
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on clansgold (accountId);

create index if not exists goldIndex
    on clansgold (serverId, gold);

create index if not exists valueIndex
    on clansgold (serverId, accountId, gold);

create table if not exists clansipbans
(
    ipAddress varchar(16) not null
        primary key,
    admin     varchar(40) null
);

create index if not exists adminIndex
    on clansipbans (admin);

create table if not exists clansiphistory
(
    ipAddress varchar(16) not null,
    accountId int         not null,
    serverId  int         not null,
    primary key (ipAddress, accountId, serverId),
    constraint clansiphistory_ibfk_1
        foreign key (serverId) references clanserver (id),
    constraint clansiphistory_ibfk_2
        foreign key (accountId) references accounts (id)
);

create index if not exists accountIndex
    on clansiphistory (accountId);

create index if not exists accountServerIndex
    on clansiphistory (accountId, serverId);

create index if not exists ipIndex
    on clansiphistory (ipAddress);

create index if not exists ipServerIndex
    on clansiphistory (ipAddress, serverId);

create index if not exists serverId
    on clansiphistory (serverId);

create table if not exists clansipwhitelists
(
    ipAddress          varchar(16) not null
        primary key,
    admin              varchar(40) null,
    additionalAccounts int         null
);

create index if not exists adminIndex
    on clansipwhitelists (admin);

create table if not exists clansmountstats
(
    mountId   int          not null
        primary key,
    statToken varchar(256) not null
);

create table if not exists clansnetherportals
(
    id           int auto_increment
        primary key,
    cornerOne    varchar(30) null,
    cornerTwo    varchar(30) null,
    returnPortal tinyint(1)  null
);

create table if not exists clansoutposts
(
    uniqueId     int         not null
        primary key,
    serverId     int         not null,
    origin       varchar(30) null,
    outpostType  tinyint     not null,
    ownerClan    int         not null,
    timeSpawned  mediumtext  null,
    outpostState tinyint     not null
);

create table if not exists clanssiegeweapons
(
    uniqueId   int          not null
        primary key,
    serverId   int          not null,
    location   varchar(30)  null,
    ownerClan  int          not null,
    weaponType tinyint      not null,
    health     int          not null,
    yaw        int          not null,
    lastFired  mediumtext   null,
    entities   varchar(200) null
);

create table if not exists clanssupplypack
(
    serverId  int      not null,
    accountId int      not null,
    usedPacks int      not null,
    useDate   datetime not null,
    primary key (serverId, accountId),
    constraint clanssupplypack_ibfk_1
        foreign key (serverId) references clanserver (id),
    constraint clanssupplypack_ibfk_2
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on clanssupplypack (accountId);

create table if not exists clanterritory
(
    id     int auto_increment
        primary key,
    clanId int          null,
    chunk  varchar(100) null,
    safe   bit          null,
    constraint clanterritory_ibfk_1
        foreign key (clanId) references clans (id)
);

create index if not exists clanId
    on clanterritory (clanId);

create table if not exists clanwar
(
    initiatorId int      not null,
    clanId      int      not null,
    score       int      not null,
    created     date     not null,
    lastUpdated date     not null,
    ended       datetime null,
    completed   bit      null
);

create table if not exists communities
(
    id     int auto_increment
        primary key,
    name   varchar(15) not null,
    region varchar(5)  not null
);

create table if not exists communityInvites
(
    accountId   int not null,
    communityId int not null
);

create table if not exists communityMembers
(
    accountId     int                  not null,
    communityId   int                  not null,
    communityRole varchar(20)          not null,
    readingChat   tinyint(1) default 0 null
);

create table if not exists communitySettings
(
    settingId    int          not null,
    communityId  int          not null,
    settingValue varchar(100) null
);

create table if not exists communityinvites
(
    accountId   int not null,
    communityId int not null
);

create table if not exists communitymembers
(
    accountId     int                  not null,
    communityId   int                  not null,
    communityRole varchar(20)          not null,
    readingChat   tinyint(1) default 0 null
);

create table if not exists communitysettings
(
    settingId    int          not null,
    communityId  int          not null,
    settingValue varchar(100) null
);

create table if not exists customData
(
    id   int auto_increment
        primary key,
    name varchar(100) null
);

create table if not exists customdata
(
    id   int auto_increment
        primary key,
    name varchar(100) null
);

create table if not exists elorating
(
    accountId int not null,
    gameType  int not null,
    elo       int null
);

create table if not exists fieldBlock
(
    id             int          not null
        primary key,
    server         varchar(100) null,
    location       varchar(100) null,
    blockId        int          null,
    blockData      tinyint      null,
    emptyId        int          null,
    emptyData      tinyint      null,
    stockMax       int          null,
    stockRegenTime double       null,
    loot           varchar(100) null
)
    charset = latin1;

create table if not exists fieldMonster
(
    id      int          not null
        primary key,
    server  varchar(100) null,
    name    varchar(100) null,
    type    varchar(100) null,
    mobMax  int          null,
    mobRate double       null,
    center  varchar(100) null,
    radius  int          null,
    height  int          null
)
    charset = latin1;

create table if not exists fieldOre
(
    id       int          not null
        primary key,
    server   varchar(100) null,
    location varchar(100) null
)
    charset = latin1;

create table if not exists fieldblock
(
    id             int          not null
        primary key,
    server         varchar(100) null,
    location       varchar(100) null,
    blockId        int          null,
    blockData      tinyint      null,
    emptyId        int          null,
    emptyData      tinyint      null,
    stockMax       int          null,
    stockRegenTime double       null,
    loot           varchar(100) null
)
    charset = latin1;

create table if not exists fieldmonster
(
    id      int          not null
        primary key,
    server  varchar(100) null,
    name    varchar(100) null,
    type    varchar(100) null,
    mobMax  int          null,
    mobRate double       null,
    center  varchar(100) null,
    radius  int          null,
    height  int          null
)
    charset = latin1;

create table if not exists fieldore
(
    id       int          not null
        primary key,
    server   varchar(100) null,
    location varchar(100) null
)
    charset = latin1;

create table if not exists forumlink
(
    accountId       int        not null
        primary key,
    powerPlayStatus tinyint(1) null,
    userId          int        not null,
    constraint forumLink_accounts_null_fk
        foreign key (accountId) references accounts (id)
);

create table if not exists giveawayeternal
(
    accountId  int         not null
        primary key,
    region     varchar(10) not null,
    serverName varchar(64) not null,
    constraint giveawayeternal_ibfk_1
        foreign key (accountId) references accounts (id)
);


/*
 TODO added accountwinstreak
 */

CREATE TABLE accountWinStreak (
                                  accountId INT NOT NULL,       -- ID of the account (foreign key or unique identifier)
                                  gameId INT NOT NULL,          -- ID of the game (foreign key or unique identifier)
                                  value INT NOT NULL DEFAULT 0, -- The win streak value, defaulted to 0
                                  PRIMARY KEY (accountId, gameId) -- Composite primary key to ensure uniqueness per account and game
);

CREATE TABLE IF NOT EXISTS `kitProgression` (
                                                `uuid` VARCHAR(36) NOT NULL,          -- Unique identifier for the user (UUID)
                                                `kitId` VARCHAR(64) NOT NULL,        -- Identifier for the kit
                                                `level` INT NOT NULL DEFAULT 0,      -- Level of progression in the kit
                                                `xp` INT NOT NULL DEFAULT 0,         -- Experience points in the kit
                                                `upgrade_level` INT NOT NULL DEFAULT 0, -- Upgrade level for the kit
                                                `default` TINYINT NOT NULL DEFAULT 0,   -- Flag indicating if this kit is the default (0 or 1)
                                                PRIMARY KEY (`uuid`, `kitId`)        -- Composite primary key ensuring uniqueness for each user's kit
);



/*
 TODO eternal giveaway table name changed?
 */
create table if not exists eternalgiveaway
(
    accountId  int         not null
        primary key,
    region     varchar(10) not null,
    serverName varchar(64) not null
);


create table if not exists hubnews
(
    newsId    int auto_increment
        primary key,
    newsValue text not null
);

create table if not exists incognitoStaff
(
    accountId int                  not null
        primary key,
    status    tinyint(1) default 0 null
);

create table if not exists incognitostaff
(
    accountId int                  not null
        primary key,
    status    tinyint(1) default 0 null
);

create table if not exists ipinfo
(
    id        int auto_increment
        primary key,
    ipAddress text not null
)
    charset = latin1;

create table if not exists itemcategories
(
    id   int auto_increment
        primary key,
    name varchar(100) null,
    constraint nameIndex
        unique (name)
)
    charset = latin1;

create table if not exists items
(
    id         int auto_increment
        primary key,
    name       varchar(100) null,
    categoryId int          null,
    rarity     int          null,
    constraint uniqueNameCategoryIndex
        unique (name, categoryId),
    constraint items_ibfk_1
        foreign key (categoryId) references itemcategories (id)
)
    charset = latin1;

create table if not exists accountinventory
(
    id        int auto_increment
        primary key,
    accountId int not null,
    itemId    int not null,
    count     int not null,
    constraint accountItemIndex
        unique (accountId, itemId),
    constraint accountInventory_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountInventory_ibfk_2
        foreign key (itemId) references items (id)
)
    charset = latin1;

create index if not exists itemId
    on accountinventory (itemId);

create index if not exists categoryId
    on items (categoryId);

create table if not exists mail
(
    id        int                                   not null
        primary key,
    accountId int                                   not null,
    sender    varchar(64)                           not null,
    message   varchar(1024)                         not null,
    archived  tinyint                               not null,
    deleted   tinyint                               not null,
    timeSent  timestamp default current_timestamp() not null on update current_timestamp(),
    constraint mail_ibfk_1
        foreign key (accountId) references accounts (id)
)
    charset = latin1;

create index if not exists accountId
    on mail (accountId);

create table if not exists mailbox
(
    id        int                                   not null
        primary key,
    accountId int                                   null,
    sender    varchar(64)                           null,
    message   varchar(1024)                         null,
    archived  tinyint                               null,
    deleted   tinyint                               null,
    timeSent  timestamp default current_timestamp() not null on update current_timestamp(),
    constraint mailbox_ibfk_1
        foreign key (accountId) references accounts (id)
)
    charset = latin1;

create index if not exists accountId
    on mailbox (accountId);

create table if not exists namehistory
(
    accountId int         not null,
    name      varchar(16) not null,
    primary key (accountId, name),
    constraint namehistory_accounts_null_fk
        foreign key (accountId) references accounts (id)
);

create table if not exists newnpcsnew
(
    id             int auto_increment
        primary key,
    entity_type    varchar(32)  not null,
    name           varchar(32)  not null,
    info           varchar(32)  null,
    world          varchar(32)  not null,
    x              double       not null,
    y              double       not null,
    z              double       not null,
    yaw            int          not null,
    pitch          int          not null,
    in_hand        varchar(32)  null,
    in_hand_data   blob         not null,
    helmet         varchar(32)  null,
    chestplate     varchar(32)  null,
    leggings       varchar(32)  null,
    boots          varchar(32)  null,
    metadata       varchar(32)  not null,
    skin_value     varchar(700) null,
    skin_signature varchar(700) null
);

create table if not exists npcs
(
    id         int auto_increment
        primary key,
    server     varchar(50)      not null,
    name       varchar(255)     null,
    world      varchar(50)      not null,
    x          float            not null,
    y          float            not null,
    z          float            not null,
    radius     float            not null,
    entityType varchar(100)     not null,
    entityMeta varchar(100)     null,
    adult      bit              not null,
    helmet     tinytext         null,
    chestplate tinytext         null,
    leggings   tinytext         null,
    boots      tinytext         null,
    inHand     tinytext         null,
    info       tinytext         null,
    infoRadius float            null,
    infoDelay  int              null,
    yaw        double default 0 not null,
    pitch      double default 0 not null,
    constraint id_2
        unique (id)
)
    charset = latin1;

create index if not exists id
    on npcs (id);

create index if not exists id_3
    on npcs (id);

create table if not exists playerinfo
(
    id      int auto_increment
        primary key,
    uuid    varchar(256) not null,
    name    text         not null,
    version text         not null
)
    charset = latin1;

create table if not exists playerips
(
    id           int auto_increment
        primary key,
    playerInfoId int  not null,
    ipInfoId     int  not null,
    date         text not null
)
    charset = latin1;

create table if not exists playerloginsessions
(
    id           int auto_increment
        primary key,
    loginTime    text not null,
    playerInfoId int  not null,
    timeInGame   text not null
)
    charset = latin1;

create table if not exists playermap
(
    id         int          not null,
    playerName varchar(256) not null,
    serverName varchar(256) not null,
    us         tinyint      not null,
    primary key (id, playerName)
)
    charset = latin1;

create table if not exists playeruniquelogins
(
    id           int auto_increment
        primary key,
    playerInfoId int  not null,
    day          text not null
)
    charset = latin1;

create table if not exists polls
(
    id          int          not null
        primary key,
    enabled     bit          null,
    question    varchar(256) not null,
    answerA     varchar(256) not null,
    answerB     varchar(256) null,
    answerC     varchar(256) null,
    answerD     varchar(256) null,
    coinReward  int          not null,
    displayType int          not null
)
    charset = latin1;

create table if not exists accountpolls
(
    id        int auto_increment,
    accountId int     not null,
    pollId    int     not null,
    value     tinyint not null,
    primary key (id, accountId, pollId),
    constraint accountPolls_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountPolls_ibfk_2
        foreign key (pollId) references polls (id)
)
    charset = latin1;

create index if not exists accountId
    on accountpolls (accountId);

create index if not exists pollId
    on accountpolls (pollId);

create table if not exists powerplayclaims
(
    accountId  int not null,
    claimYear  int not null,
    claimMonth int not null,
    constraint powerplayclaims_ibfk_1
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on powerplayclaims (accountId);

create table if not exists powerplaysubs
(
    accountId int          not null,
    startDate date         not null,
    duration  varchar(256) not null,
    constraint powerplaysubs_ibfk_1
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on powerplaysubs (accountId);

create table if not exists preferences
(
    accountId  int not null,
    preference int not null,
    value      int not null
);

create table if not exists rankbenefits
(
    id        int auto_increment
        primary key,
    accountId int          null,
    benefit   varchar(100) null,
    constraint id
        unique (id)
)
    charset = latin1;

create index if not exists accountId
    on rankbenefits (accountId);

create table if not exists reportcategorytypes
(
    id   tinyint(4) unsigned not null
        primary key,
    name varchar(16)         not null
);

create table if not exists reportresulttypes
(
    id         tinyint(4) unsigned not null
        primary key,
    globalStat tinyint(1)          not null,
    name       varchar(16)         not null
);

create table if not exists reportteams
(
    id   tinyint     not null
        primary key,
    name varchar(50) not null
);

create table if not exists reportteammemberships
(
    accountId int     not null,
    teamId    tinyint not null,
    primary key (accountId, teamId),
    constraint reportTeams_accounts_id_fk
        foreign key (accountId) references accounts (id),
    constraint reportTeams_reportTeamTypes_id_fk
        foreign key (teamId) references reportteams (id)
);

create index if not exists reportTeams_accountId_index
    on reportteammemberships (accountId);

create table if not exists salesannouncements
(
    id      int          null,
    ranks   varchar(250) null,
    message varchar(256) null,
    enabled bit          null,
    clans   bit          null
);

create table if not exists serverpassword
(
    id       int          not null
        primary key,
    server   varchar(100) null,
    password varchar(100) null
)
    charset = latin1;

create table if not exists snapshots
(
    id        int auto_increment
        primary key,
    token     char(8)                              null,
    created   datetime default current_timestamp() not null,
    creatorId int                                  null,
    constraint snapshots_token_uindex
        unique (token),
    constraint snapshots_accounts_id_fk
        foreign key (creatorId) references accounts (id)
);

create table if not exists reports
(
    id           int(11) unsigned auto_increment
        primary key,
    suspectId    int                 not null,
    categoryId   tinyint(4) unsigned not null,
    region       varchar(5)          null,
    snapshotId   int                 null,
    assignedTeam tinyint             null,
    constraint accounts_accountsId_id_fk
        foreign key (suspectId) references accounts (id),
    constraint reportCategoryTypes_categoryId_id_fk
        foreign key (categoryId) references reportcategorytypes (id),
    constraint reports_reportTeams_teamId_fk
        foreign key (assignedTeam) references reportteams (id),
    constraint reports_snapshots_id_fk
        foreign key (snapshotId) references snapshots (id)
);

create table if not exists reporthandlers
(
    reportId  int unsigned         not null,
    handlerId int                  not null,
    aborted   tinyint(1) default 0 not null,
    primary key (reportId, handlerId),
    constraint reportHandlers_accountStat_accountId_fk
        foreign key (handlerId) references accounts (id),
    constraint reportHandlers_reports_id_fk
        foreign key (reportId) references reports (id)
            on delete cascade
);

create index if not exists reportHandlers_reportId_index
    on reporthandlers (reportId);

create table if not exists reportreasons
(
    reportId   int(11) unsigned not null,
    reporterId int              not null,
    reason     varchar(100)     not null,
    server     varchar(50)      not null,
    weight     int default 0    not null,
    time       datetime         not null,
    primary key (reportId, reporterId),
    constraint reportReasons_accounts_id_fk
        foreign key (reporterId) references accounts (id),
    constraint reportReasons_reports_id_fk
        foreign key (reportId) references reports (id)
            on delete cascade
);

create table if not exists reportresults
(
    reportId   int(11) unsigned not null
        primary key,
    resultId   tinyint          not null,
    reason     varchar(256)     null,
    closedTime datetime         not null,
    constraint reportResults_reports_id_fk
        foreign key (reportId) references reports (id)
            on delete cascade
);

create index if not exists reportResults_reportResultTypes_id_fk
    on reportresults (resultId);

create index if not exists reports_suspect_id_index
    on reports (suspectId);

create table if not exists snapshottypes
(
    id   tinyint unsigned not null
        primary key,
    name varchar(25)      not null,
    constraint reportMessageTypes_id_uindex
        unique (id)
);

create table if not exists snapshotmessages
(
    id           bigint auto_increment
        primary key,
    senderId     int                                  not null,
    server       varchar(25)                          not null,
    time         datetime default current_timestamp() not null,
    message      varchar(150)                         not null,
    snapshotType tinyint unsigned                     not null,
    constraint reportChatLog_accounts_id_fk
        foreign key (senderId) references accounts (id),
    constraint reportChatMessages_reportMessageTypes_id_fk
        foreign key (snapshotType) references snapshottypes (id)
);

create table if not exists snapshotmessagemap
(
    snapshotId int    not null,
    messageId  bigint not null,
    primary key (snapshotId, messageId),
    constraint snapshotMessageMap_snapshotMessages_id_fk
        foreign key (messageId) references snapshotmessages (id)
            on delete cascade,
    constraint snapshotMessageMap_snapshots_id_fk
        foreign key (snapshotId) references snapshots (id)
            on delete cascade
);

create table if not exists snapshotrecipients
(
    messageId   bigint not null,
    recipientId int    not null,
    primary key (messageId, recipientId),
    constraint reportMessageRecipients_accounts_id_fk
        foreign key (recipientId) references accounts (id),
    constraint snapshotRecipients_snapshotMessages_id_fk
        foreign key (messageId) references snapshotmessages (id)
            on delete cascade
);

create table if not exists spawns
(
    id         int          not null
        primary key,
    serverName varchar(100) null,
    location   varchar(100) null
)
    charset = latin1;

create table if not exists specificyoutube
(
    accountId int      not null,
    clickTime datetime not null,
    constraint specificyoutube_ibfk_1
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on specificyoutube (accountId);

create table if not exists statevents
(
    eventId     int unsigned      not null,
    accountId   int unsigned      not null,
    date        date              not null,
    gamemode    tinyint unsigned  not null,
    serverGroup varchar(100)      not null,
    type        tinyint unsigned  not null,
    value       smallint unsigned not null,
    primary key (eventId, accountId, date, gamemode, serverGroup, type)
)
    charset = latin1;

create table if not exists stats
(
    id   int auto_increment,
    name varchar(100) not null,
    primary key (id, name)
)
    charset = latin1;

create table if not exists accountstat
(
    accountId int    not null,
    statId    int    not null,
    value     bigint null,
    primary key (accountId, statId),
    constraint accountStat_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountStat_ibfk_2
        foreign key (statId) references stats (id)
)
    charset = latin1;

create index if not exists statId
    on accountstat (statId);

create table if not exists accountstats
(
    id        int not null
        primary key,
    accountId int not null,
    statId    int not null,
    value     int not null,
    constraint accountStats_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountStats_ibfk_2
        foreign key (statId) references stats (id)
)
    charset = latin1;

create index if not exists accountId
    on accountstats (accountId);

create index if not exists statId
    on accountstats (statId);

create table if not exists accountstatsalltime
(
    accountId int    not null,
    statId    int    not null,
    value     bigint not null,
    primary key (accountId, statId),
    constraint accountstatsalltime_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountstatsalltime_ibfk_2
        foreign key (statId) references stats (id)
);

create index if not exists statId
    on accountstatsalltime (statId);

create index if not exists valueIndex
    on accountstatsalltime (value);

create table if not exists accountstatsdaily
(
    accountId int    not null,
    statId    int    not null,
    date      date   not null,
    value     bigint not null,
    primary key (accountId, statId),
    constraint accountstatsdaily_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountstatsdaily_ibfk_2
        foreign key (statId) references stats (id)
);

create index if not exists dateIndex
    on accountstatsdaily (date);

create index if not exists statId
    on accountstatsdaily (statId);

create index if not exists valueIndex
    on accountstatsdaily (value);

create table if not exists accountstatsmonthly
(
    accountId int    not null,
    statId    int    not null,
    date      date   not null,
    value     bigint not null,
    primary key (accountId, statId),
    constraint accountstatsmonthly_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountstatsmonthly_ibfk_2
        foreign key (statId) references stats (id)
);

create index if not exists dateIndex
    on accountstatsmonthly (date);

create index if not exists statId
    on accountstatsmonthly (statId);

create index if not exists valueIndex
    on accountstatsmonthly (value);

create table if not exists accountstatsweekly
(
    accountId int    not null,
    statId    int    not null,
    date      date   not null,
    value     bigint not null,
    primary key (accountId, statId),
    constraint accountstatsweekly_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountstatsweekly_ibfk_2
        foreign key (statId) references stats (id)
);

create index if not exists dateIndex
    on accountstatsweekly (date);

create index if not exists statId
    on accountstatsweekly (statId);

create index if not exists valueIndex
    on accountstatsweekly (value);

create table if not exists accountstatsyearly
(
    accountId int    not null,
    statId    int    not null,
    date      date   not null,
    value     bigint not null,
    primary key (accountId, statId),
    constraint accountstatsyearly_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountstatsyearly_ibfk_2
        foreign key (statId) references stats (id)
);

create index if not exists dateIndex
    on accountstatsyearly (date);

create index if not exists statId
    on accountstatsyearly (statId);

create index if not exists valueIndex
    on accountstatsyearly (value);

create table if not exists statseasons
(
    id         smallint                                not null
        primary key,
    seasonName varchar(50)                             not null,
    startDate  timestamp default '1970-01-01 02:00:01' not null,
    endDate    timestamp default '1970-01-01 02:00:01' not null,
    constraint seasonIndex
        unique (seasonName)
);

create table if not exists accountstatsseasonal
(
    accountId int      not null,
    statId    int      not null,
    seasonId  smallint not null,
    value     bigint   not null,
    primary key (accountId, statId),
    constraint accountstatsseasonal_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountstatsseasonal_ibfk_2
        foreign key (statId) references stats (id),
    constraint accountstatsseasonal_ibfk_3
        foreign key (seasonId) references statseasons (id)
);

create index if not exists seasonIndex
    on accountstatsseasonal (seasonId);

create index if not exists statId
    on accountstatsseasonal (statId);

create index if not exists valueIndex
    on accountstatsseasonal (value);

create index if not exists endIndex
    on statseasons (endDate);

create index if not exists startIndex
    on statseasons (startDate);

create table if not exists stattypes
(
    id   tinyint unsigned not null,
    name varchar(100)     not null,
    primary key (id, name)
)
    charset = latin1;

create table if not exists tasks
(
    id   int          not null,
    name varchar(100) not null,
    primary key (id, name)
)
    charset = latin1;

create table if not exists accounttasks
(
    id        int not null
        primary key,
    accountId int not null,
    taskId    int not null,
    constraint accountTasks_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountTasks_ibfk_2
        foreign key (taskId) references tasks (id)
)
    charset = latin1;

create index if not exists accountId
    on accounttasks (accountId);

create index if not exists taskId
    on accounttasks (taskId);

create table if not exists tournamentlb
(
    `rank`    int unsigned not null,
    accountId int unsigned not null,
    value     int unsigned not null,
    primary key (`rank`, accountId)
)
    charset = latin1;

create table if not exists transactions
(
    id   int         not null
        primary key,
    name varchar(60) not null
)
    charset = latin1;

create table if not exists accounttransactions
(
    id            int auto_increment
        primary key,
    accountId     int not null,
    transactionId int not null,
    coins         int null,
    gems          int null,
    constraint accountTransactions_ibfk_1
        foreign key (accountId) references accounts (id),
    constraint accountTransactions_ibfk_2
        foreign key (transactionId) references transactions (id)
)
    charset = latin1;

create index if not exists accountId
    on accounttransactions (accountId);

create index if not exists transactionId
    on accounttransactions (transactionId);

create table if not exists twofactor
(
    accountId int  not null,
    secretKey text null
);

create table if not exists twofactor_history
(
    accountId int  not null,
    ip        text null,
    loginTime date null
);

create table if not exists youtube
(
    accountId int      not null,
    clickTime datetime not null,
    constraint youtube_ibfk_1
        foreign key (accountId) references accounts (id)
);

create index if not exists accountId
    on youtube (accountId);

create definer = root@`%` event if not exists report_cleanup on schedule
    every '1' DAY
        starts '2023-05-15 00:00:00'
    on completion preserve
    enable
    comment 'Cleans up old report and snapshot data.'
    do
    BEGIN
        -- DELETE REPORTS (AND ASSOCIATED SNAPSHOT IF ANY) CLOSED > 30 DAYS AGO
        DELETE reports, snapshots
        FROM reports
                 LEFT JOIN reportResults ON reports.id = reportResults.reportId
                 LEFT JOIN snapshots ON reports.snapshotId = snapshots.id
        WHERE reportResults.closedTime NOT BETWEEN NOW() - INTERVAL 30 DAY AND NOW();

        -- DELETE SNAPSHOTS NOT LINKED TO REPORT AND OLDER THAN 30 DAYS
        DELETE snapshots
        FROM snapshots
                 LEFT JOIN reports ON snapshots.id = reports.snapshotId
        WHERE reports.id IS NULL
          AND snapshots.created NOT BETWEEN NOW() - INTERVAL 30 DAY AND NOW();

        -- DELETE ORPHANED SNAPSHOT MESSAGES
        DELETE snapshotMessages
        FROM snapshotMessages
                 LEFT JOIN snapshotMessageMap ON snapshotMessages.id = snapshotMessageMap.messageId
        WHERE snapshotMessageMap.snapshotId IS NULL;
    END;


