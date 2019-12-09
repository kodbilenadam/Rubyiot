require "httparty"
require "json"
require 'colorize'

class Rubyiot
  include HTTParty

  base_uri "https://tr1.api.riotgames.com/"

  @@ritoapikey = "RGAPI-d1a059f7-387d-497a-8882-b06de398d394"
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
    getChampionMasteryURL = "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{@@summonerId}/by-champion/#{championId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getChampionMasteryURL)
    getChampionMasteryInfo = self.class.get(urifix)
    jsonGetChampionMastery = JSON.parse(getChampionMasteryInfo.body)
  end

  def getChampionMasteryScore
    getChampionMasteryScoreURL = "/lol/champion-mastery/v4/scores/by-summoner/#{@@summonerId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getChampionMasteryScoreURL)
    getChampionMasteryScoreInfo = self.class.get(urifix)
    jsonGetChampionMasteryScore = JSON.parse(getChampionMasteryScoreInfo.body)
  end

  def getChampionInfo
    getChampionInfoURL = "/lol/platform/v3/champion-rotations?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getChampionInfoURL)
    getChampionInfo = self.class.get(urifix)
    jsonGetChampionInfo = JSON.parse(getChampionInfo.body)
  end
end

api = Rubyiot.new
info = api.getBySummonerName("KodBilenAdam")


a = api.getAllChampionMasteries

def champIdToName champId
  JSON.parse(File.read("data/champions.json"))["#{champId}"]
end

# a[0..4].each do|i|
#   puts "Şampiyon: #{champIdToName i["championId"]} | Şampiyon Puanı: #{i["championPoints"]} | Seviye: #{i["championLevel"]}".colorize(:yellow)
# end