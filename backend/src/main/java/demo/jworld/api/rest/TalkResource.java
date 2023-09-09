package demo.jworld.api.rest;

import demo.jworld.api.model.Talk;
import demo.jworld.api.model.Vote;
import demo.jworld.api.repository.TalkRepository;
import demo.jworld.api.repository.VoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
public class TalkResource {

    @Autowired
    private TalkRepository talks;

    @Autowired
    private VoteRepository votes;

    @GetMapping("/talks")
    List<Talk> getTalks() {
        return talks.findAll();
    }

    @GetMapping("/talks/{talkId}")
    Talk getTalk(@PathVariable Long talkId) {
        return talks.findById(talkId).orElse(null);
    }

    @GetMapping("/talks/{talkId}/votes")
    List<Vote> getTalkVotes(@PathVariable Long talkId) {
        var talkResult = talks.findById(talkId);
        if (talkResult.isPresent()) {
            return votes.findByTalk(talkResult.get());
        }
        return List.of();
    }

    @PutMapping("/talks/{talkId}/votes")
    void createVote(@PathVariable Long talkId, @RequestBody VoteRequest request) {
        var talkResult = talks.findById(talkId);
        if (talkResult.isEmpty()) {
            return;
        }

        var vote = new Vote();
        vote.setId(UUID.randomUUID().toString());
        vote.setValue(request.value());
        vote.setTalk(talkResult.get());
        votes.save(vote);
    }

    public record VoteRequest(Integer value) {
    }

}
