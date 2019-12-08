require "httparty"
require "json"

class Rubyiot
  include HTTParty

  base_uri "https://tr1.api.riotgames.com/"

  @@ritoapikey = "RGAPI-d2bbc60a-2f91-4385-95c8-f4f9d3d1599d"
  def getBySummonerName(summonerName)
    sumName = CGI.escape summonerName.downcase.gsub(/\s/, '')
    getSummonerURL = "/lol/summoner/v4/summoners/by-name/#{sumName}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getSummonerURL)
    summonerInfo = self.class.get(urifix)
    jsonSummonerInfo = JSON.parse(summonerInfo.body)
    @@summonerId =  jsonSummonerInfo["id"]
    jsonSummonerInfo
  end

  def getLeagueEntriesForSummoner
    getSummonerLeagueURL = "/lol/league/v4/entries/by-summoner/#{@@summonerId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getSummonerLeagueURL)
    summonerLeagueInfo = self.class.get(urifix)
    jsonSummonerLeagueInfo = JSON.parse(summonerLeagueInfo.body)
  end

  def getCurrentGameInfoBySummoner
    getCurrentGameInfoBySummonerURL = "/lol/spectator/v4/active-games/by-summoner/#{@@summonerId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getCurrentGameInfoBySummonerURL)
    summonerActiveGameInfo = self.class.get(urifix)
    jsonSummonerActiveGamesInfo = JSON.parse(summonerActiveGameInfo.body)
  end

  def getShardData
    getServiceStatusURL = "/lol/status/v3/shard-data?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getServiceStatusURL)
    serviceStatusInfo = self.class.get(urifix)
    jsonServiceStatusInfo = JSON.parse(serviceStatusInfo.body)
  end

  def getFeaturedGames
    getFeaturedGamesURL = "/lol/spectator/v4/featured-games?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getFeaturedGamesURL)
    featuredGamesInfo = self.class.get(urifix)
    jsonGetFeaturedGames = JSON.parse(featuredGamesInfo.body)
  end

  def getAllChampionMasteries
    getAllChampionMasteriesURL = "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{@@summonerId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getAllChampionMasteriesURL)
    getAllChampionMasteriesInfo = self.class.get(urifix)
    jsonGetAllChampionMasteries = JSON.parse(getAllChampionMasteriesInfo.body)
  end

  def getChampionMastery(championId)
    getChampionMasteryURL = "https://tr1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/#{@@summonerId}/by-champion/#{championId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getChampionMasteryURL)
    getChampionMasteryInfo = self.class.get(urifix)
    jsonGetChampionMastery = JSON.parse(getChampionMasteryInfo.body)
  end

end

api = Rubyiot.new
info = api.getBySummonerName("KodBilenAdam")
