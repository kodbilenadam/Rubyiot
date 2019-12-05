require "httparty"
require "json"

class Rubyiot
  include HTTParty

  base_uri "https://tr1.api.riotgames.com/"

  @@ritoapikey = "api_key_here"
  def summonerInfo(summonerName)
    sumName = CGI.escape summonerName.downcase.gsub(/\s/, '')
    getSummonerURL = "/lol/summoner/v4/summoners/by-name/#{sumName}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getSummonerURL)
    summonerInfo = self.class.get(urifix)
    jsonSummonerInfo = JSON.parse(summonerInfo.body)
    @@summonerId =  jsonSummonerInfo["id"]
    jsonSummonerInfo
  end

  def summonerLeagueInfo
    getSummonerLeagueURL = "/lol/league/v4/entries/by-summoner/#{@@summonerId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getSummonerLeagueURL)
    summonerLeagueInfo = self.class.get(urifix)
    jsonSummonerLeagueInfo = JSON.parse(summonerLeagueInfo.body)
  end

  def spectatorActiveGame
    getSummonerActiveGameURL = "/lol/spectator/v4/active-games/by-summoner/#{@@summonerId}?api_key=#{@@ritoapikey}"
    urifix = URI.parse(getSummonerActiveGameURL)
    summonerActiveGameInfo = self.class.get(urifix)
    jsonSummonerActiveGamesInfo = JSON.parse(summonerActiveGameInfo.body)
  end
end

api = Rubyiot.new
info = api.summonerInfo("KodBilenAdam")